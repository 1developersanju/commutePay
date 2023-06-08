#include <Arduino.h>
#if defined(ESP32) || defined(ARDUINO_RASPBERRY_PI_PICO_W)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <Arduino_JSON.h>
#include <TinyGPSPlus.h>
#include <HardwareSerial.h>
#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN  21  // ESP32 pin GIOP5 
#define RST_PIN 22 // ESP32 pin GIOP27 
MFRC522 rfid(SS_PIN, RST_PIN);

#define WIFI_SSID "Sanjwifi"
#define WIFI_PASSWORD "12345678"
#define API_KEY "AIzaSyBrVKrvqDr1UEnLwnLYFy_wObt8FgJGQrs"
#define FIREBASE_PROJECT_ID "commutepay-a0052"
#define USER_EMAIL "admin.ad@gmail.com"
#define USER_PASSWORD "test123"

TinyGPSPlus gps;
HardwareSerial ss(1);
String latitude = "0.0";
String longitude = "0.0";

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
WiFiMulti multi;
#endif

void setup() {
  ss.begin(9600, SERIAL_8N1, 16, 17);
  Serial.begin(9600);
  SPI.begin(); // init SPI bus
  rfid.PCD_Init(); // init MFRC522

#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
  multi.addAP(WIFI_SSID, WIFI_PASSWORD);
  multi.run();
#else
  Serial.print("Connecting to Wi-Fi");
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
#endif

  Serial.print("Connecting to Wi-Fi");
  unsigned long ms = millis();
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
    if (millis() - ms > 10000) {
      Serial.println("Failed to connect to WiFi.");
      return;
    }
#endif
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
  config.wifi.clearAP();
  config.wifi.addAP(WIFI_SSID, WIFI_PASSWORD);
#endif

  config.token_status_callback = tokenStatusCallback;

#if defined(ESP8266)
  fbdo.setBSSLBufferSize(2048, 2048);
#endif

  fbdo.setResponseSize(2048);

  Firebase.begin(&config, &auth);

  Firebase.reconnectWiFi(true);
}

bool update_st(String uid, int travelst) {
  Serial.println("updating st...");
  std::vector<struct fb_esp_firestore_document_write_t> writes;
  struct fb_esp_firestore_document_write_t update_write;
  update_write.type = fb_esp_firestore_document_write_type_update;
  FirebaseJson content;
  String documentPath = "users/" + uid;
  content.set("fields/travel_st/integerValue", travelst + 1);

  update_write.update_document_content = content.raw();
  update_write.update_masks = "travel_st";
  update_write.update_document_path = documentPath.c_str();
  writes.push_back(update_write);

  if (Firebase.Firestore.commitDocument(&fbdo, FIREBASE_PROJECT_ID, "", writes, ""))
    return true;
  else
    return false;
}

bool update_dta(String uid, int travelst) {
  Serial.println("updating dta...");
  std::vector<struct fb_esp_firestore_document_write_t> writes;
  struct fb_esp_firestore_document_write_t update_write;
  update_write.type = fb_esp_firestore_document_write_type_update;
  FirebaseJson content;
  String documentPath = "travel_data/" + uid + "_" + String(travelst);
  content.set("fields/travel_st/integerValue", travelst);

  update_write.update_document_content = content.raw();
  update_write.update_masks = "travel_st";
  update_write.update_document_path = documentPath.c_str();
  writes.push_back(update_write);

  if (Firebase.Firestore.commitDocument(&fbdo, FIREBASE_PROJECT_ID, "", writes, ""))
    return true;
  else
    return false;
}

int read_travel_st(String uid) {
  Serial.println("reading travel_st...");
  String mask = "travel_st";
  String documentPath = "users/" + uid;
  if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), mask.c_str())) {
    String dta = String(fbdo.payload().c_str());
    JSONVar obj = JSON.parse(dta);
    return obj["fields"]["travel_st"]["integerValue"];
  }
  else {
    Serial.println(fbdo.errorReason());
    return -1;
  }
}

void loop() {
  if (rfid.PICC_IsNewCardPresent()) {
    rfid.PICC_ReadCardSerial();
    String uid = "";
    for (byte i = 0; i < rfid.uid.size; i++) {
      uid.concat(String(rfid.uid.uidByte[i] < 0x10 ? "0" : ""));
      uid.concat(String(rfid.uid.uidByte[i], HEX));
    }
    uid.toUpperCase();
    if (!got_crd(uid)) {
      Serial.println("Failed to update Firestore");
    }
    delay(1000);
  }
}
 
bool got_crd(String uid) {
  if (Firebase.ready()) {
    int travel_st = read_travel_st(uid);
    if(travel_st == -1)
      return false;
    Serial.println(travel_st);
    if(!update_dta(uid, travel_st))
      return false;
    if(!update_st(uid, travel_st))
      return false;
    return true;
  }
  return false;
}
