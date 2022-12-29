#include "Arduino.h"
#include <OneWire.h>
#include <DallasTemperature.h>

const int SENSOR_PIN = 13; // Arduino pin connected to DS18B20 sensor's DQ pin
OneWire oneWire(SENSOR_PIN);         // setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

extern void soilMoistCalibration();
extern void waterLevelCalibration();
extern void temperatureRead(DallasTemperature tempSensor);

void setup() {
	Serial.begin(9600); // open serial port, set the baud rate as 9600 bps
	tempSensor.begin();    // initialize the sensor
}

void loop() {
    // soilMoistCalibration();
    // waterLevelCalibration();
	temperatureRead(tempSensor);
}