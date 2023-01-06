#include "Arduino.h"

void LDRInit() {
    // Y0
    digitalWrite(D2, LOW);
    digitalWrite(D1, LOW);
    digitalWrite(D0, LOW);
    delay(50);
}

int LDRRead(int sensor)
{   
    // Select LDR from demux
    LDRInit();

    int val = 0;
    for (int i = 0; i < 10; i++) {
        val += analogRead(sensor);
        delay(50);
    }
    
    Serial.println("LDR read."); // print the value to serial port
    return val/10;
}

// value_1 = 900
// value_2 = 700
// value_3 = 400
// value_4 = 100