#include "Arduino.h"
extern void soilMoistCalibration();
extern void waterLevelCalibration();

void setup()
{
  Serial.begin(9600); // open serial port, set the baud rate as 9600 bps
}
void loop()
{
    // soilMoistCalibration();
    waterLevelCalibration();
}