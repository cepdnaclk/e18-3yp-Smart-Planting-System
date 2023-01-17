#include "Arduino.h"

int waterLevelCalibration(int sensor_pin)
{
	int val;
	val = analogRead(sensor_pin); // connect sensor to Analog 0
	

	int result = 1000;

	if(val > 600) result = 0;
	else if(val > 500) result = 1;
	else if(val > 50) result = 2;
	else result = 3;

	Serial.println(val); // print the value to serial port

	delay(500);
	return result; 
}

// 0-300 => level 3    -------- OK
// 300-500 => level 2  -------- OK
// 500-650 => level 1  -------- Low water warning
// >650 => level 0     -------- Do not turn on pump!!


// no water: <1200
// little water: 1500
// half water: 1650
// full water: 1800