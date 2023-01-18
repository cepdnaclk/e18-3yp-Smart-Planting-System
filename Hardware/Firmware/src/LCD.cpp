// Display
#include <Adafruit_GFX.h>
#include <MCUFRIEND_kbv.h>
#include <Fonts/FreeSans9pt7b.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <Arduino.h>

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
// #define BROWN 0xC530
#define BROWN 0xFFFA


extern uint8_t logoGraphic[];
extern uint8_t tempOuter[];
extern uint8_t lampOnGraphic[];
extern uint8_t lampOffGraphic[];
extern uint8_t soil[];
extern uint8_t waterPumpOn[];
extern uint8_t waterPumpOff[];
extern uint8_t level[];
extern uint8_t sunHigh[];
extern uint8_t sunLow[];

extern float getTemperature(DallasTemperature);
extern char LDRRead(int);
extern String soilMoistureRead(int);
extern String waterLevelRead(int);

// void showMsgXY(int x, int y, int sz, const GFXfont *f, const char *msg, int color) {
void showMsgXY(int x, int y, int sz, const char *msg, int color)
{
  int16_t x1, y1;
  uint16_t wid, ht;
  // tft.drawFastHLine(0, y, tft.width(), WHITE);
  tft.setFont(&FreeSans9pt7b);
  tft.setCursor(x, y);
  tft.setTextColor(color);
  tft.setTextSize(sz);
  tft.print(msg);
  delay(400);
}
void drawBitmap(int16_t x, int16_t y, const uint8_t *bitmap, int16_t w, int16_t h, uint16_t color)
{

  int16_t i, j, byteWidth = (w + 7) / 8;
  uint8_t byte;

  for (j = 0; j < h; j++)
  {
    for (i = 0; i < w; i++)
    {
      if (i & 7)
        byte <<= 1;
      else
        byte = pgm_read_byte(bitmap + j * byteWidth + i / 8);
      if (byte & 0x80)
        tft.drawPixel(x + i, y + j, color);
    }
  }
}

void tftInit(String DEVICE_ID)
{
  uint16_t ID = tft.readID();
  Serial.print("TFT ID = 0x");
  Serial.println(ID, HEX);

  tft.reset();

  if (ID == 0xD3D3)
    ID = 0x9486; // write-only shield
  tft.begin(ID);
  tft.setRotation(0); // Vertical
  // tft.invertDisplay(1);

  tft.fillScreen(BLACK);
  String myId = "Device ID ";
  myId.concat(DEVICE_ID);
  showMsgXY(5, 25, 1, myId.c_str(), WHITE);
  drawBitmap(58, 100, logoGraphic, 124, 180, GREEN);
}

void highLight() { 
  tft.fillRect(47, 187, 30, 30, BLACK);
  drawBitmap(47, 187, sunHigh, 30, 30, RED);
}
void lowLight() { 
  tft.fillRect(47, 187, 30, 30, BLACK);
  drawBitmap(47, 187, sunLow, 30, 30, TFT_ORANGE);
}

void temperatureBox() {
  tft.drawRoundRect(8, 50, 108, 82, 5, WHITE);
  showMsgXY(10, 68, 1, "Temperature", WHITE);
  // draw temperature icon
  drawBitmap(78, 72, tempOuter, 28, 56, WHITE);
  tft.fillCircle(88, 118, 4, RED);
  tft.fillRoundRect(87, 90, 4, 30, 2, RED);
}
void soilMoistBox() {
  tft.drawRoundRect(123, 50, 108, 82, 5, WHITE);
  showMsgXY(125, 68, 1, "Soil Moisture", WHITE);
  drawBitmap(160, 93, soil, 30, 30, BROWN);
}
void LDRBox() {
  tft.drawRoundRect(8, 140, 108, 82, 5, WHITE);
  showMsgXY(44, 158, 1, "Light", WHITE);
}
void waterLvlBox() {
  tft.drawRoundRect(123, 140, 108, 82, 5, WHITE);
  showMsgXY(132, 158, 1, "Water level", WHITE);
  drawBitmap(160, 186, level, 20, 30, WHITE);
}
void lightBox() {
  tft.drawRoundRect(8, 230, 108, 82, 5, WHITE);
  showMsgXY(42, 248, 1, "Lamp", WHITE);

}
void motorBox() {
  tft.drawRoundRect(123, 230, 108, 82, 5, WHITE);
  showMsgXY(128, 248, 1, "Water Pump", WHITE);
}

void drawBoxes()
{
  temperatureBox();
  soilMoistBox();
  lightBox();
  LDRBox();
  waterLvlBox();
  motorBox();
  // showValues(tempSensor, waterSensor);
}

void clearScreen() {
  tft.fillRect(0, 40, 240, 280, BLACK);
}

void lampOn() {
  tft.fillRect(46, 253, 38, 19, BLACK);
  showMsgXY(47, 268, 1, "On", WHITE);
  tft.fillRect(44, 275, 35, 35, BLACK);
  drawBitmap(44, 275, lampOnGraphic, 35, 35, YELLOW);
}
void lampOff() {
  tft.fillRect(46, 253, 38, 19, BLACK);
  showMsgXY(47, 268, 1, "Off", WHITE);
  tft.fillRect(44, 275, 35, 35, BLACK);
  drawBitmap(44, 275, lampOffGraphic, 35, 35, WHITE);
}

void pumpOn() {
  tft.fillRect(156, 253, 40, 19, BLACK);
  showMsgXY(157, 268, 1, "On", WHITE);
  tft.fillRect(156, 273, 35, 35, BLACK);
  drawBitmap(156, 273, waterPumpOn, 35, 35, BLUE);
}
void pumpOff() {
  tft.fillRect(156, 253, 40, 19, BLACK);
  showMsgXY(157, 268, 1, "Off", WHITE);
  tft.fillRect(156, 273, 35, 35, BLACK);
  drawBitmap(156, 273, waterPumpOff, 35, 35, BLUE);
}

void lightLvlDisplay(char ldrSensorVal) {
  // Light
  tft.fillRect(13, 164, 100, 19, BLACK);
  if(ldrSensorVal == 'F') {
    showMsgXY(14, 180, 1, "Full Shade", WHITE);
    highLight();
  }
  else if(ldrSensorVal == 'S') {
    showMsgXY(14, 178, 1, "Semi Shade", WHITE);
    lowLight();
  }
  else {
    showMsgXY(14, 178, 1, "No Shade", WHITE);
    lowLight();
  }
}

void soilMoistDisplay(String soilVal) {
    // soil moisture
  tft.fillRect(128, 73, 100, 19, BLACK);
  if(soilVal.equals("D")) {
    showMsgXY(129, 88, 1, "Dry Soil", WHITE);
  }
  else if(soilVal.equals("M")) {
    showMsgXY(129, 88, 1, "Low moisture", WHITE);
  }
  else if(soilVal.equals("We")) {
    showMsgXY(129, 88, 1, "Wet", WHITE);
  }
  else {
    showMsgXY(129, 88, 1, "Watery", WHITE);
  }
}

void showTemperature(float tempVal) {
  // Temperature
  char str[6];
  dtostrf(tempVal, 2, 1, str);
  tft.fillRect(13, 74, 38, 19, BLACK);
  showMsgXY(52, 90, 1, "`C", WHITE);
  showMsgXY(14, 90, 1, str, WHITE);
}

void showWaterLvl(String waterLvlVal) {
  // Water level
  tft.fillRect(128, 164, 100, 20, BLACK);
  showMsgXY(148, 180, 1, waterLvlVal.c_str(), WHITE);
}