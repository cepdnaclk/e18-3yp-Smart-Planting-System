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
MCUFRIEND_kbv tft;
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

const String DEVICE_ID = "01";
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
extern int waterLevelRead(int);
extern float temperatureRead(DallasTemperature tempSensor);
extern int LDRRead(int);
String getDateTime();
void connectWiFi();
void connectFirebase();
void sendData();
void tftInit();
void showMsgXY(int, int, int, const GFXfont *, const char *, int);
void drawBitmap(int16_t, int16_t,const uint8_t *, int16_t, int16_t, uint16_t);

String soilMoistVal = "";
int waterLevelVal = 0;
char lightIntensityVal;
float temperatureVal = 0;
String timeString = "";
String dateString = "";

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

	tftInit();

	tempSensor.begin(); // initialize the temperature sensor
	delay(2000);

	// Power for temperature sensor
	pinMode(16, OUTPUT);

	connectWiFi();

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
	// sendData();
	tft.fillScreen(DARKGREEN);
	delay(2000);
}

String getDateTime()
{
	timeClient.update();
	time_t epochTime = timeClient.getEpochTime();
	struct tm *ptm = gmtime((time_t *)&epochTime);
	int monthDay = ptm->tm_mday;
	int currentMonth = ptm->tm_mon + 1;
	int currentYear = ptm->tm_year + 1900;
	dateString = String(monthDay) + "-" + String(currentMonth) + "-" + String(currentYear);
	timeString = timeClient.getFormattedTime();
	return (dateString + " " + timeString);
}

void connectWiFi() {
	WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
	Serial.print("Connecting to Wi-Fi");
	while (WiFi.status() != WL_CONNECTED)
	{
		Serial.print(".");
		delay(300);
	}
	Serial.println();
	Serial.println("Wifi connected");
	// Serial.print("Connected with IP: ");
	// Serial.println(WiFi.localIP());
}

void connectFirebase() {

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
	/*temperatureVal = temperatureRead(tempSensor);
	Serial.print(temperatureVal);
	Serial.println("°C");
	delay(10);*/

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
}

void tftInit() {
  uint16_t ID = tft.readID();
  Serial.print("TFT ID = 0x");
  Serial.println(ID, HEX);

  tft.reset();

  if (ID == 0xD3D3) ID = 0x9486;  // write-only shield
  tft.begin(ID);
  tft.setRotation(1);  //PORTRAIT
  // tft.invertDisplay(1);

  tft.fillScreen(BLACK);
}

void showMsgXY(int x, int y, int sz, const GFXfont *f, const char *msg, int color) {
  int16_t x1, y1;
  uint16_t wid, ht;
  //tft.drawFastHLine(0, y, tft.width(), WHITE);
  tft.setFont(f);
  tft.setCursor(x, y);
  tft.setTextColor(color);
  tft.setTextSize(sz);
  tft.print(msg);
  delay(400);
}

void drawBitmap(int16_t x, int16_t y, const uint8_t *bitmap, int16_t w, int16_t h, uint16_t color) {

  int16_t i, j, byteWidth = (w + 7) / 8;
  uint8_t byte;

  for(j=0; j<h; j++) {
    for(i=0; i<w; i++) {
      if(i & 7) byte <<= 1;
      else      byte   = pgm_read_byte(bitmap + j * byteWidth + i / 8);
      if(byte & 0x80) tft.drawPixel(x+i, y+j, color);
    }
  }
}