#include <Arduino.h>

void waterLevelInit() {
    // Y2
    digitalWrite(D2, LOW);
    digitalWrite(D1, HIGH);
    digitalWrite(D0, LOW);
    delay(20000);			// Wait 20 seconds
}

int waterLevelRead(int sensor_pin)
{	
	// Select water level sensor from demux
	waterLevelInit();

	int val = 0;
	int result = 1000;

	for (int i = 0; i < 10; i++) {
        val += analogRead(sensor_pin);
        delay(50);
    }
	val /= 10;

	if(val > 600) result = 0;
	else if(val > 500) result = 1;
	else if(val > 50) result = 2;
	else result = 3;

	Serial.print("Water level: ");
	// Serial.print(val);
	// Serial.print("  ");
	return result;
}

// 0-300 => level 3    -------- OK
// 300-500 => level 2  -------- OK
// 500-650 => level 1  -------- Low water warning
// >650 => level 0     -------- Do not turn on pump!!