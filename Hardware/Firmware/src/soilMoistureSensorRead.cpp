#include <Arduino.h>

void soilMoistInit() {
    // Y1
    digitalWrite(D2, LOW);
    digitalWrite(D1, LOW);
    digitalWrite(D0, HIGH);
    delay(10000);           // Wait 20 seconds
}

int soilMoistureRead(int sensor)
{
    // Select Soil moisture sensor from demux
    soilMoistInit();

    int val = 0;
    for (int i = 0; i < 10; i++) {
        val += analogRead(sensor);
        delay(50);
    }
    
    Serial.print("Soil moisture read: "); // print the value to serial port
    return val/10;
}

// value_1 = 550
// value_2 = 245