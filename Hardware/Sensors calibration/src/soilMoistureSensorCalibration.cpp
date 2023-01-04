#include "Arduino.h"

void soilMoistCalibration()
{
    int val;
    val = analogRead(0); // connect sensor to Analog 0
    Serial.println(val); // print the value to serial port
    delay(100);
}

// value_1 = 550
// value_2 = 245