#include "Arduino.h"

char LDRRead(int sensor)
{
    int val = 0;
    delay(500);
    val = analogRead(sensor);
    Serial.print("LDR read: "); // print the value to serial port

    if(val >= 3500) return 'F';
    else if(val >= 1500) return 'S';
    else return 'N';
}

// value_1 = 3400
// value_2 = 2500

// Full shade > 3400
// 3400 > Semi Shade > 1500
// 1500 > No Shade