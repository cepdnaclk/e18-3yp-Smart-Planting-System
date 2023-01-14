#include <Arduino.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SD.h>

#include <NTPClient.h>
#include <WiFiUdp.h>

#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

const String DEVICE_ID = "01";
const int SENSOR_PIN = A0; // All the analog read is connected to A0 pin of ESP8266 board
const int TEMP_SENSOR = 12;		// Temperature sensor connected on pin D6(GPIO 12)

const long utcOffsetInSeconds = 19800;

// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

OneWire oneWire(TEMP_SENSOR);			// setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

extern int soilMoistureRead(int);
extern int waterLevelRead(int);
extern float temperatureRead(DallasTemperature tempSensor);
extern int LDRRead(int);

int soilMoistVal = 0;
int waterLevelVal = 0;
int lightIntensityVal = 0;
float temperatureVal = 0;
String timeString = "";
String dateString = "";

// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
#define WIFI_SSID "Dialog_4G_336"
#define WIFI_PASSWORD "56483cdD"

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
	
	// Pins for select the device from demux
	pinMode(D0, OUTPUT);
	pinMode(D1, OUTPUT);
	pinMode(D2, OUTPUT);

	tempSensor.begin(); // initialize the temperature sensor
	delay(2000);
	WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
	Serial.print("Connecting to Wi-Fi");
	while (WiFi.status() != WL_CONNECTED)
	{
		Serial.print(".");
		delay(300);
	}
	Serial.println();
	// Serial.print("Connected with IP: ");
	// Serial.println(WiFi.localIP());
	Serial.println();

	Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

	/* Assign the api key (required) */
	config.api_key = API_KEY;

	config.database_url = DATABASE_URL;

	Firebase.begin(DATABASE_URL, API_KEY);

	// Comment or pass false value when WiFi reconnection will control by your code or third party library
	// Firebase.reconnectWiFi(true);

	Firebase.setDoubleDigits(5);
	timeClient.begin();
	timeClient.setTimeOffset(utcOffsetInSeconds);
}

void loop()
{
	// Get date and time from NTP server
	timeClient.update();
	time_t epochTime = timeClient.getEpochTime();
	struct tm *ptm = gmtime ((time_t *)&epochTime);
	int monthDay = ptm->tm_mday;
	int currentMonth = ptm->tm_mon+1;
	int currentYear = ptm->tm_year+1900;
	dateString = String(monthDay) + "-" + String(currentMonth) + "-" + String(currentYear);
	timeString = timeClient.getFormattedTime();
	Serial.println(dateString + " " + timeString);

	// Take reading from LDR
	lightIntensityVal = LDRRead(SENSOR_PIN);
	Serial.println(lightIntensityVal);
	delay(10);

	// Take reading from soil moisture sensor
	soilMoistVal = soilMoistureRead(SENSOR_PIN);
	Serial.println(soilMoistVal);
	delay(10);

	// Take readings from water level depth sensor
	waterLevelVal = waterLevelRead(SENSOR_PIN);
	Serial.println(waterLevelVal);
	delay(10);

	// Take readings from temperature sensor
	temperatureVal = temperatureRead(tempSensor);
	Serial.print(temperatureVal);
	Serial.println("°C");
	delay(10);


	// waterLevelRead(SENSOR_PIN);
	// temperatureRead(tempSensor);
	/*if (Firebase.ready())
	{
		// Firebase.setInt(fbdo, string, 5);
		Firebase.setInt(fbdo, "/" + DEVICE_ID + "/soilMoisture", soilMoistVal);
		Firebase.setInt(fbdo, "/" + DEVICE_ID + "/waterLevel", 10);
		delay(200);

		Serial.print("Soil moisture-- ");
		Serial.println(soilMoistVal);

		Serial.println();
		Serial.println("------------------");
		Serial.println();
	}
	delay(10000);*/
	delay(2000);
}
