#include "Arduino.h"

extern void turnOnLamp();
extern void turnOffLamp();
extern void lightLvlDisplay(char);

char LDRRead(int sensor)
{
    int val = 0;
    // delay(300);
    val = analogRead(sensor);
    Serial.print("LDR read: "); // print the value to serial port

    if(val >= 3500) {
        turnOffLamp();
        lightLvlDisplay('N');
        return 'N';
    }
    else if(val >= 1500) {
        turnOffLamp();
        lightLvlDisplay('S');
        return 'S';
    }
    else {
        turnOnLamp();
        lightLvlDisplay('F');
        return 'F';
    }
}

// value_1 = 3400
// value_2 = 2500

// Full shade > 3400
// 3400 > Semi Shade > 1500
// 1500 > No Shade