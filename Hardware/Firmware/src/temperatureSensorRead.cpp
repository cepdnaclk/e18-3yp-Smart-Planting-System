#include <OneWire.h>
#include <DallasTemperature.h>

float tempCelsius;	  // temperature in Celsius
float tempFahrenheit; // temperature in Fahrenheit

extern void showTemperature(float);

float temperatureRead(DallasTemperature tempSensor)
{
	// Initialize temperature probe by write high to GPIO16
	digitalWrite(19, HIGH);
	delay(1000);

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

	digitalWrite(16, LOW);
	showTemperature(tempCelsius);

	return tempCelsius;
}