#include <Arduino.h>

extern void showWaterLvl(String);

String waterLevelRead(int sensor_pin)
{	
	int val = 0;
	String result = "";

    val = analogRead(sensor_pin);

	if(val > 1250) result = "level 3";
	else if(val > 1100) result = "level 2";
	else if(val > 900) result = "level 1";
	else result = "level 0";

	// result = "level ";

	Serial.print("Water level: ");
	Serial.print(val);
	Serial.print(" ");
	Serial.println(result);
	showWaterLvl(result);
	// Serial.print("  ");
	return result;
}

// >1250 => level 3    -------- OK
// 1250-1100 => level 2  -------- OK
// 1100-900 => level 1  -------- Low water warning
// <900 => level 0     -------- Do not turn on pump!!

// no water: <900
// little water: 1100 < x < 900
// half water: 1100 < x < 1250
// full water: 1250