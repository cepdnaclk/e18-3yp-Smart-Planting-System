#include "Arduino.h"

int soilMoistCalibration(int sensor)
{
    int val;
    delay(200);
    val = analogRead(sensor); // connect sensor to Analog 0

    Serial.println(val); // print the value to serial port
    return val;
}

// value_1 = 3100   Air
// value_2 = 2600
// value_3 = 2200   Water

// Dry > 1900
// 1900 > Moist > 1500
// 1500 > Wet > 700
// 700 > Water 