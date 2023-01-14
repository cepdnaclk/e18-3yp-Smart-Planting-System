#include "Arduino.h"

int soilMoistCalibration(int sensor)
{
    int val;
    delay(100);
    val = analogRead(sensor); // connect sensor to Analog 0

    Serial.println(val); // print the value to serial port
    return val;
}

// value_1 = 550
// value_2 = 245