#include "Arduino.h"

int LDRRead(int sensor)
{
    int val;
    val = analogRead(sensor); // connect sensor to Analog 0
    Serial.println(val); // print the value to serial port
    return val;
}

// value_1 = 550
// value_2 = 245