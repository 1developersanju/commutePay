#include <Arduino.h>
#if defined(ESP32) || defined(ARDUINO_RASPBERRY_PI_PICO_W)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>
#include <Arduino_JSON.h>

#define WIFI_SSID "S4njeev_4G"
#define WIFI_PASSWORD "Flutterian2004"
#define API_KEY "AIzaSyBYK0pD5MniN7UW2RVbCHs9aw8ph9wyT1k"
#define FIREBASE_PROJECT_ID "bench-20658"
#define USER_EMAIL "sltestsraj@gmail.com"
#define USER_PASSWORD "machine2003"


FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

int count = 0;

#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
WiFiMulti multi;
#endif

void setup()
{
  Serial.begin(115200);
#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
  multi.addAP(WIFI_SSID, WIFI_PASSWORD);
  multi.run();
#else
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
#endif

  Serial.print("Connecting to Wi-Fi");
  unsigned long ms = millis();
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
    if (millis() - ms > 10000)
      break;
#endif
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  // The WiFi credentials are required for Pico W
  // due to it does not have reconnect feature.
#if defined(ARDUINO_RASPBERRY_PI_PICO_W)
  config.wifi.clearAP();
  config.wifi.addAP(WIFI_SSID, WIFI_PASSWORD);
#endif

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h

#if defined(ESP8266)
  // In ESP8266 required for BearSSL rx/tx buffer for large data handle, increase Rx size as needed.
  fbdo.setBSSLBufferSize(2048 /* Rx buffer size in bytes from 512 - 16384 /, 2048 / Tx buffer size in bytes from 512 - 16384 */);
#endif

  // Limit the size of response payload to be collected in FirebaseData
  fbdo.setResponseSize(2048);

  Firebase.begin(&config, &auth);

  Firebase.reconnectWiFi(true);
}
void update_st(String uid,int travelst) {
  Serial.println("updating st...");
  std::vector<struct fb_esp_firestore_document_write_t> writes;
  struct fb_esp_firestore_document_write_t update_write;
  update_write.type = fb_esp_firestore_document_write_type_update;
  FirebaseJson content;
  String documentPath = "users/" + uid;
  content.set("fields/travel_st/integerValue", travelst+1);

  update_write.update_document_content = content.raw();
  update_write.update_masks = "travel_st";
  update_write.update_document_path = documentPath.c_str();
  writes.push_back(update_write);
  if (Firebase.Firestore.commitDocument(&fbdo, FIREBASE_PROJECT_ID, "" /* databaseId can be (default) or empty /, writes / dynamic array of fb_esp_firestore_document_write_t /, "" / transaction */))
    Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
  else
    Serial.println(fbdo.errorReason());
}


void update_dta(String uid,int travelst) {
  Serial.println("updating data...");
  std::vector<struct fb_esp_firestore_document_write_t> writes;
  struct fb_esp_firestore_document_write_t update_write;
  update_write.type = fb_esp_firestore_document_write_type_update;
  FirebaseJson content;

  String st_chs = (travelst%2!=0)?"unboarding":"boarding";
  Serial.println(st_chs);
  String documentPath = "users/" + uid + "/travel_data/" + String((travelst%2!=0)?travelst:travelst/2 + 1);
  content.set("fields/"+st_chs+"/mapValue/fields/date/stringValue", "12342");
  content.set("fields/"+st_chs+"/mapValue/fields/time/stringValue", "12342");
  content.set("fields/"+st_chs+"/mapValue/fields/lat/stringValue", "0.0");
  content.set("fields/"+st_chs+"/mapValue/fields/lon/stringValue", "0.0");

  //  content.set("boarding/time","12335");

  update_write.update_document_content = content.raw();
  update_write.update_masks = st_chs;
  update_write.update_document_path = documentPath.c_str();
  writes.push_back(update_write);
  if (Firebase.Firestore.commitDocument(&fbdo, FIREBASE_PROJECT_ID, "" /* databaseId can be (default) or empty /, writes / dynamic array of fb_esp_firestore_document_write_t /, "" / transaction */))
    Serial.printf("ok\n%s\n\n", fbdo.payload().c_str());
  else
    Serial.println(fbdo.errorReason());
}

String read_travel_st(String uid) {
  Serial.println("reading travel st...");
  String documentPath = "users/" + uid;
  String mask = "travel_st";
  if (Firebase.Firestore.getDocument(&fbdo, FIREBASE_PROJECT_ID, "", documentPath.c_str(), mask.c_str())) {
    String dta = String(fbdo.payload().c_str());
    JSONVar obj = JSON.parse(dta);
    return obj["fields"]["travel_st"]["integerValue"];
  }
  else
    Serial.println(fbdo.errorReason());
}




bool st = false;
void loop()
{
  if (Firebase.ready() && !st)
  {
    st = true;

    String uid = "userid";
    int travel_st = read_travel_st(uid).toInt();
    Serial.println(travel_st);
    update_dta(uid,travel_st);
    update_st(uid,travel_st);
  }
}
