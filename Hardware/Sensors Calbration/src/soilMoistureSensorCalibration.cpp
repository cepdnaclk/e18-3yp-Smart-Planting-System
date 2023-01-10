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

// Dry > 3100
// 3100 > Moist > 2500
// 2500 > Wet > 2000
// 2000 > Water 