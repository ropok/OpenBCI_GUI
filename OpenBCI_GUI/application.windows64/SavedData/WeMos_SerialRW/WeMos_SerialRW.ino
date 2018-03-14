#define WEMOS_RX D6 //connect to STXD on SIM5320
#define WEMOS_TX D7 //connect to SRXD on SIM5320
#define FONA_RST 4 //not used

#include <SoftwareSerial.h>
SoftwareSerial wemosSS = SoftwareSerial(WEMOS_RX, WEMOS_TX); //need to check this carefully
SoftwareSerial *wemosSerial = &wemosSS;

#include <DHT.h>

void setup() {
  Serial.begin(57600);
  wemosSerial->begin(9600);
}

void loop() {
  while (wemosSS.available()) {
    Serial.write(wemosSS.read());
  }
  while (Serial.available()) {
    wemosSS.write(Serial.read());
  }
}

