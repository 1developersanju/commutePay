#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN  21  // ESP32 pin GIOP5 
#define RST_PIN 22 // ESP32 pin GIOP27 

MFRC522 rfid(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(9600);
  SPI.begin(); // init SPI bus
  rfid.PCD_Init(); // init MFRC522

  Serial.println("Tap an RFID/NFC tag on the RFID-RC522 reader");
}

void loop() {
  if (rfid.PICC_IsNewCardPresent()) { // new tag is available
    if (rfid.PICC_ReadCardSerial()) { // NUID has been read
      MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
      Serial.println(rfid.PICC_GetTypeName(piccType));

      // print UID in Serial Monitor in the hex format
      String temp_str = "";
      for (int i = 0; i < rfid.uid.size; i++) {
        temp_str = temp_str + String(rfid.uid.uidByte[i], DEC);
      }
      got_crd(temp_str);

      rfid.PICC_HaltA(); // halt PICC
      rfid.PCD_StopCrypto1(); // stop encryption on PCD
    }
  }
}

bool got_crd(String uid) {
  Serial.println(uid);
  return true; // or false, depending on your logic
}
