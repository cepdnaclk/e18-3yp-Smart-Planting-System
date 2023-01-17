#include <Arduino.h>

String waterLevelRead(int sensor_pin)
{	
	int val = 0;
	String result = "";

    val = analogRead(sensor_pin);

	if(val > 1700) result = "level 3";
	else if(val > 1400) result = "level 2";
	else if(val > 1200) result = "level 1";
	else result = "level 0";

	Serial.print("Water level: ");
	Serial.print(val);
	Serial.print(" ");
	Serial.println(result);
	// Serial.print("  ");
	return result;
}

// > 1700 => level 3    -------- OK
// 1700-1400 => level 2  -------- OK
// 1400-1200 => level 1  -------- Low water warning
// >1200 => level 0     -------- Do not turn on pump!!

// no water: <1200
// little water: 1500
// half water: 1650
// full water: 1800