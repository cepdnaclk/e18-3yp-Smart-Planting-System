#include <Arduino.h>

extern void soilMoistDisplay(String);

String soilMoistureRead(int sensor)
{
    int val = 0;
    delay(1000);
    val = analogRead(sensor);
    for (int i = 0; i < 10; i++) {
        val += analogRead(sensor);
        delay(50);
    }
    
    Serial.print("Soil moisture read: "); // print the value to serial port

    val = val/10;
    
    if(val >= 1850) {
        soilMoistDisplay("D");
        return "D";
    }
    else if(val >= 1500) {
        soilMoistDisplay("M");
        return "M";
    }
    else if(val >= 700) {
        soilMoistDisplay("We");
        return "We";
    }
    else {
        soilMoistDisplay("Wa");
        return "Wa";
    }
}

// value_1 = 3100   Air
// value_2 = 2600
// value_3 = 2200   Water

// Dry > 1900
// 1900 > Moist > 1500
// 1500 > Wet > 700
// 700 > Water 