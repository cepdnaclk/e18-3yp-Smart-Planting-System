#include "Arduino.h"

void setup()
{
  Serial.begin(9600); // open serial port, set the baud rate as 9600 bps
}
void loop()
{
  int val;
  val = analogRead(0); // connect sensor to Analog 0
  Serial.println(val); // print the value to serial port
  delay(100);
}

// value_1 = 550
// value_2 = 245