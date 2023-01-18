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

// Display
#include <Adafruit_GFX.h>
#include <MCUFRIEND_kbv.h>

const int TS_LEFT = 760, TS_RT = 135, TS_TOP = 180, TS_BOT = 910;
#define BLACK 0x0000
#define BLUE 0x001F
#define RED 0xF800
#define GREEN 0x07E0
#define CYAN 0x07FF
#define MAGENTA 0xF81F
#define YELLOW 0xFFE0
#define WHITE 0xFFFF
#define NAVY 0x000F
#define DARKGREEN 0x03E0
#define PURPLE 0x780F

const String DEVICE_ID = "2";
// Input pins
const int WATER_LEVEL_SENSOR_IN = 34; // Water level sensor on GPIO34
const int SOIL_MOIST_SENSOR_IN = 39;  // Soil moisture sensor on GPIO39 (SN)
const char LDR_SENSOR_IN = 36;		  // LDR sensor on GPIO36 (SP)
const int TEMP_SENSOR_IN = 22;		  // Temperature sensor on GPIO22
// Output pins
const int LED1_OUT = 18;
const int LED2_OUT = 19;
const int MOTOR_OUT = 21;

const long utcOffsetInSeconds = 19800;

// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

OneWire oneWire(TEMP_SENSOR_IN);		// setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

extern String soilMoistureRead(int);
extern String waterLevelRead(int);
extern float temperatureRead(DallasTemperature tempSensor);
extern int LDRRead(int);
String getDateTime();
String getTime();
void connectWiFi();
extern void sendData();
extern void tftInit(String);
extern void showMsgXY(int, int, int, const char *, int);
// void showMsgXY(int, int, int, const GFXfont *, const char *, int);
extern void drawBitmap(int16_t, int16_t,const uint8_t *, int16_t, int16_t, uint16_t);
extern void clearScreen();
extern void drawBoxes();
extern void motorBox();
extern void lightBox();
extern void watering(String, String);

// Graphics
extern uint8_t wifiGraphic[];
extern uint8_t noWifiGraphic[];

String soilMoistVal = "";
String waterLevelVal = "";
char lightIntensityVal;
float temperatureVal = 0;
String timeString = "";
String dateString = "";

// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
// #define WIFI_SSID "Dialog 4G 517"
// #define WIFI_PASSWORD "576E5Fc3"
// #define WIFI_SSID "Redmi Note 7"
// #define WIFI_PASSWORD "Anush123ga"
#define WIFI_SSID "Dialog_4G_336"
#define WIFI_PASSWORD "56483cdD"
// #define WIFI_SSID "Eng-Student"
// #define WIFI_PASSWORD "3nG5tuDt"

// For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino

/* 2. Define the API Key */
#define API_KEY "qSErU9t9a7O8Tj2vTJWPdatLBlbFJ58c7twgkIuh"

/* 3. Define the RTDB URL */
#define DATABASE_URL "smart-planting-system-b7c5e-default-rtdb.asia-southeast1.firebasedatabase.app" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

// Define Firebase Data object
FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

void setup()
{
	Serial.begin(9600); // open serial port, set the baud rate as 9600 bps

	tftInit(DEVICE_ID);

	tempSensor.begin(); // initialize the temperature sensor
	delay(2000);

	// Power for temperature sensor
	pinMode(19, OUTPUT);
	pinMode(18, OUTPUT);
	pinMode(21, OUTPUT);
	pinMode(23, OUTPUT);

	connectWiFi();

	// Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

	/* Assign the api key (required) */
	config.api_key = API_KEY;

	config.database_url = DATABASE_URL;

	Firebase.begin(DATABASE_URL, API_KEY);

	// Comment or pass false value when WiFi reconnection will control by your code or third party library
	// Firebase.reconnectWiFi(true);

	Firebase.setDoubleDigits(2);
	timeClient.begin();
	timeClient.setTimeOffset(utcOffsetInSeconds);
	clearScreen();
}

void loop()
{
	// digitalWrite(18, HIGH);	// LED
	// delay(1000);
	// digitalWrite(18, LOW);
	// digitalWrite(23, HIGH);	// motor
	// delay(1000);
	// digitalWrite(23, LOW);
	drawBoxes();
	sendData();
}

String getDateTime()
{
	timeClient.update();
	time_t epochTime = timeClient.getEpochTime();
	struct tm *ptm = gmtime((time_t *)&epochTime);
	int monthDay = ptm->tm_mday;
	int currentMonth = ptm->tm_mon + 1;
	int currentYear = ptm->tm_year + 1900;

	String dash = "-";
	dateString = String(monthDay);
	dateString.concat(dash);
	dateString.concat(currentMonth);
	dateString.concat(dash);
	dateString.concat(currentYear);

	timeString = timeClient.getFormattedTime();

	String space = " ";
	dateString.concat(space);
	dateString.concat(timeString);

	return dateString;
}
String getTime()
{
	timeClient.update();
	timeString = timeClient.getFormattedTime();
	return timeString;
}

void connectWiFi() {
	drawBitmap(210, 10, wifiGraphic, 20, 18, BLACK);
	drawBitmap(210, 10, noWifiGraphic, 20, 18, WHITE);
	WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
	while (WiFi.status() != WL_CONNECTED)
	{
		delay(300);
	}
	drawBitmap(210, 10, noWifiGraphic, 20, 18, BLACK);
	drawBitmap(210, 10, wifiGraphic, 20, 18, WHITE);

	// Serial.print("Connected with IP: ");
	// Serial.println(WiFi.localIP());
}

String stringAdd(String str1, const char* char1) {
	String str2 = char1;
	str1.concat(str2);
	return str1;
}

void sendData() {
	// Get date and time from NTP server
	Serial.println(getDateTime());

	// Take reading from LDR
	lightIntensityVal = LDRRead(LDR_SENSOR_IN);
	Serial.println(lightIntensityVal);
	delay(10);

	// Take reading from soil moisture sensor
	soilMoistVal = soilMoistureRead(SOIL_MOIST_SENSOR_IN);
	Serial.println(soilMoistVal);
	delay(10);

	// Take readings from water level depth sensor
	waterLevelVal = waterLevelRead(WATER_LEVEL_SENSOR_IN);
	Serial.println(waterLevelVal);
	delay(10);

	// Take readings from temperature sensor
	temperatureVal = temperatureRead(tempSensor);
	Serial.print(temperatureVal);
	Serial.println("°C");
	delay(10);

	String path = "/plants/";
	path.concat(DEVICE_ID);

	watering(soilMoistVal, waterLevelVal);

	if (Firebase.ready())
	{
		Firebase.setString(fbdo, stringAdd(path, "/DateTime"), getDateTime());
		Firebase.setString(fbdo, stringAdd(path, "/SoilMoisture"), soilMoistVal);
		Firebase.setString(fbdo, stringAdd(path, "/WaterLevel"), waterLevelVal);
		Firebase.setString(fbdo, stringAdd(path, "/LightIntensity"), String(lightIntensityVal));
		Firebase.setFloat(fbdo, stringAdd(path, "/Temperature"), temperatureVal);

		// Serial.print("Soil moisture- ");
		// Serial.println(soilMoistVal);

		// Serial.println();
		Serial.println("------------------");
		Serial.println();
	}

	delay(500);
}
