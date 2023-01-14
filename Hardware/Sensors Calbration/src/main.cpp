#include <Arduino.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SD.h>

#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

const String DEVICE_ID = "01";

// Input pins
const int WATER_LEVEL_SENSOR_IN = 34;	// Water level sensor on GPIO34
const int SOIL_MOIST_SENSOR_IN = 39;	// Soil moisture sensor on GPIO39 (SN)
const int LDR_SENSOR_IN = 36;			// LDR sensor on GPIO36 (SP)
const int TEMP_SENSOR_IN = 22;				// Temperature sensor on GPIO22
// Output pins
const int LED1_OUT = 18;
const int LED2_OUT = 19;
const int MOTOR_OUT = 21;

OneWire oneWire(TEMP_SENSOR_IN);			// setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

extern int soilMoistCalibration(int);
extern int waterLevelCalibration(int);
extern void temperatureRead(DallasTemperature tempSensor, int TEMP_SENSOR_IN);
extern int LDRRead(int);

int soilMoistVal = 0;
int waterLevelVal = 0;

// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
#define WIFI_SSID "Dialog 4G 517"
#define WIFI_PASSWORD "576E5Fc3"

// For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino

/* 2. Define the API Key */
#define API_KEY "vBYe3iwFcnUvU8OOAKngy3Ne6aZTe53RArDxuOVC"

/* 3. Define the RTDB URL */
#define DATABASE_URL "test-hardware-project-default-rtdb.asia-southeast1.firebasedatabase.app" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

void setup()
{
	Serial.begin(9600); // open serial port, set the baud rate as 9600 bps
	tempSensor.begin(); // initialize the temperature sensor

	delay(2000);
	/*WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
	Serial.print("Connecting to Wi-Fi");
	while (WiFi.status() != WL_CONNECTED)
	{
		Serial.print(".");
		delay(300);
	}
	Serial.println();
	Serial.print("Connected with IP: ");
	Serial.println(WiFi.localIP());
	Serial.println();

	Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

	// Assign the api key (required)
	config.api_key = API_KEY;

	config.database_url = DATABASE_URL;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// Please make sure the device free Heap is not lower than 80 k for ESP32 and 10 k for ESP8266,
	// otherwise the SSL connection will fail.
	//////////////////////////////////////////////////////////////////////////////////////////////

	Firebase.begin(DATABASE_URL, API_KEY);

	// Comment or pass false value when WiFi reconnection will control by your code or third party library
	// Firebase.reconnectWiFi(true);

	Firebase.setDoubleDigits(5);*/
	Serial.println("Start");
}

void loop()
{
	// soilMoistVal = soilMoistCalibration(SOIL_MOIST_SENSOR_IN);
	// waterLevelCalibration(WATER_LEVEL_SENSOR_IN);
	// temperatureRead(tempSensor, TEMP_SENSOR_IN);
	Serial.println(LDRRead(LDR_SENSOR_IN));
	// Serial.println("----------------------------");

	/*if (Firebase.ready())
	{
		// Firebase.setInt(fbdo, main, 5);
		Firebase.setInt(fbdo, "/" + DEVICE_ID + "/soilMoisture", soilMoistVal);
		Firebase.setInt(fbdo, "/" + DEVICE_ID + "/waterLevel", 10);
		delay(200);

		Serial.print("Soil moisture-- ");
		Serial.println(soilMoistVal);

		Serial.println();
		Serial.println("------------------");
		Serial.println();
	}*/
	// delay(1000);
}
