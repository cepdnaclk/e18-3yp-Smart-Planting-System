#include "Arduino.h"
#include <NTPClient.h>
#include <WiFiUdp.h>

// Define NTP Client to get time
WiFiUDP ntpUDP2;
NTPClient timeClient2(ntpUDP2, "pool.ntp.org");

extern void lampOn();
extern void lampOff();

int LED_PIN = 18;

int getNowHour()
{
	timeClient2.update();
	int hour = timeClient2.getHours();
	return hour;
}

void turnOnLamp() {
    int hour = getNowHour();
    Serial.println(hour);
    digitalWrite(LED_PIN, HIGH);
    lampOn();
}

void turnOffLamp() {
    digitalWrite(LED_PIN, LOW);
    lampOff();
}