#include <Arduino.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SD.h>

#define DEVICE_ID "01";
const int SENSOR_PIN = A0; 				// All the analog read is connected to A0 pin of ESP8266 board

OneWire oneWire(SENSOR_PIN);         	// setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

extern void soilMoistCalibration(int);
extern void waterLevelCalibration(int);
extern void temperatureRead(DallasTemperature tempSensor);

void setup() {
	Serial.begin(9600); // open serial port, set the baud rate as 9600 bps
	tempSensor.begin();    // initialize the temperature sensor
}

void loop() {
    soilMoistCalibration(SENSOR_PIN);
    // waterLevelCalibration(SENSOR_PIN);
	// temperatureRead(tempSensor);
}