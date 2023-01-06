#include <Arduino.h>

void waterLevelInit() {
    // Y2
    digitalWrite(D2, LOW);
    digitalWrite(D1, HIGH);
    digitalWrite(D0, LOW);
    delay(50);
}

int waterLevelRead(int sensor_pin)
{
	int val;
	val = analogRead(sensor_pin); // connect sensor to Analog 0
	
	delay(100);

	int result = 1000;
	if(val > 650) result = 0;
	else if(val > 500) result = 1;
	else if(val > 300) result = 2;
	else result = 3;

	Serial.println(result); // print the value to serial port
	return result;
}

// 0-300 => level 3    -------- OK
// 300-500 => level 2  -------- OK
// 500-650 => level 1  -------- Low water warning
// >650 => level 0     -------- Do not turn on pump!!