#include <HardwareSerial.h>

HardwareSerial gps(1);

void setup() {
  gps.begin(9600, SERIAL_8N1, 16, 17);
  Serial.begin(9600);
}

void loop() {
  while(gps.available() > 0){
    Serial.write(gps.read());
  }
}
