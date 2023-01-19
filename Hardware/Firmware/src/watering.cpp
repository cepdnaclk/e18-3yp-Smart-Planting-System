#include <Arduino.h>

int WATER_PUMP_OUT = 23;

extern void pumpOn();
extern void pumpOff();

void watering(String soilMoist, String waterLvl) {
    if(soilMoist.equals("D") || soilMoist.equals("M")) {
        if(waterLvl.equals("level 3")) {
            Serial.println("-----Water pump-----");
            pumpOn();
            digitalWrite(WATER_PUMP_OUT, HIGH);
            delay(2500);
            digitalWrite(WATER_PUMP_OUT, LOW);
            pumpOff();
        }
        else if(waterLvl.equals("level 2")) {
            Serial.println("-----Water pump-----");
            pumpOn();
            digitalWrite(WATER_PUMP_OUT, HIGH);
            delay(2500);
            digitalWrite(WATER_PUMP_OUT, LOW);
            pumpOff();
        }
        else if(waterLvl.equals("level 1")) {
            digitalWrite(WATER_PUMP_OUT, LOW);
            pumpOff();
        }
        else {
            digitalWrite(WATER_PUMP_OUT, LOW);
            pumpOff();
        }
    }
    else {
        digitalWrite(WATER_PUMP_OUT, LOW);
        pumpOff();
    }
}