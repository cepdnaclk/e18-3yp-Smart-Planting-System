#include "Arduino.h"

int LDRRead(int sensor)
{
    int val = 0;
    val = analogRead(sensor);
    delay(200);
    //Serial.print("LDR read: "); // print the value to serial port
    return val;
}

// value_1 = 3400
// value_2 = 2500

// Full shade > 3400
// 3400 > Semi Shade > 1500
// 1500 > No Shade