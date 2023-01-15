#include <Arduino.h>

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
        
    if(val >= 3100) return "D";
    else if(val >= 2500) return "M";
    else if(val >= 2000) return "We";
    else return "Wa";
}

// value_1 = 3100   Air
// value_2 = 2600
// value_3 = 2200   Water

// Dry > 3100
// 3100 > Moist > 2500
// 2500 > Wet > 2000
// 2000 > Water 