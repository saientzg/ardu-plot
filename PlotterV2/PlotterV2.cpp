/*
  PlotterV2.cpp - 
*/

#include "Arduino.h"
#include "PlotterV2.h"

PlotterV2::PlotterV2(void) {
	
}


void PlotterV2::portInit(int dataPort, double portMin, double portMax) {
  Serial.print("PORT_INIT ");
  Serial.print(dataPort);
  Serial.print(",");
  
  Serial.print(portMin);
  Serial.print(",");
  
  Serial.print(portMax);
  Serial.print("\n");
}


void PlotterV2::plot(int dataPort, int serieNum, String serieName, double value, String setcolor) {
  Serial.print("DATA ");
  Serial.print(dataPort);
  Serial.print(",");
  
  Serial.print(serieNum);
  Serial.print(",");
  
  Serial.print(serieName);
  Serial.print(",");

  Serial.print(value);
  Serial.print(",");

  Serial.print(setcolor);
  Serial.print("\n");
}

void PlotterV2::log(String value) {
    Serial.print("LOG ");
    Serial.print(value);
	Serial.print("\n");
}

void PlotterV2::log(int value) {
    Serial.print("LOG ");
    Serial.print(value);
	Serial.print("\n");
}

void PlotterV2::log(double value) {
    Serial.print("LOG ");
    Serial.print(value,3);
	Serial.print("\n");
}

void PlotterV2::log(float value) {
    Serial.print("LOG ");
    Serial.print(value,3);
	Serial.print("\n");
}

void PlotterV2::log(long value) {
    Serial.print("LOG ");
    Serial.print(value,3);
	Serial.print("\n");
}
