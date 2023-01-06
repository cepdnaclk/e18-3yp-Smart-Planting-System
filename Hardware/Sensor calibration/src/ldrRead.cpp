#include "Arduino.h"

void LDRInit() {
    // Y0
    digitalWrite(D2, LOW);
    digitalWrite(D1, LOW);
    digitalWrite(D0, LOW);
    delay(500);             // Wait
}

int LDRRead(int sensor)
{   
    // Select LDR from demux
    LDRInit();

    int val = 0;
    val = analogRead(sensor);
    Serial.print("LDR read: "); // print the value to serial port
    return val;
}

// value_1 = 900
// value_2 = 700
// value_3 = 400
// value_4 = 100