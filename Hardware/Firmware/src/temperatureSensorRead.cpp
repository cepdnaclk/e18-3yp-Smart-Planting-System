#include <OneWire.h>
#include <DallasTemperature.h>

float tempCelsius;	  // temperature in Celsius
float tempFahrenheit; // temperature in Fahrenheit

void tempSensorInit() {
	// Y3
	digitalWrite(D2, LOW);
	digitalWrite(D1, HIGH);
	digitalWrite(D0, HIGH);
    delay(50);
}

float temperatureRead(DallasTemperature tempSensor)
{
	tempSensorInit();
	tempSensor.requestTemperatures();			 // send the command to get temperatures
	tempCelsius = tempSensor.getTempCByIndex(0); // read temperature in Celsius

	while(tempCelsius < -100) {
		// error in connection
		Serial.println("Temperature error");
		delay(500);
		tempCelsius = tempSensor.getTempCByIndex(0); // read temperature in Celsius
	}

	tempFahrenheit = tempCelsius * 9 / 5 + 32;	 // convert Celsius to Fahrenheit

	Serial.print("Temperature: ");
	// Serial.print(tempCelsius); // print the temperature in Celsius
	// Serial.print("°C");

	return tempCelsius;

	delay(500);
}
