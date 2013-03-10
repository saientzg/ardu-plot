/*
  PlotterV2.h - Library for Plotting into Processing.
  Created by Gustavo Saientz & Gustavo Arjones.
  Released into the public domain.
*/
#ifndef PlotterV2_h
#define PlotterV2_h

#include "Arduino.h"

class PlotterV2
{
  public:
    PlotterV2(void);
    void portInit(int dataPort, double portMin, double portMax);
    void plot(int dataPort, int serieNum, String serieName, double value, String setcolor);
	void log(String value);
	void log(int value);
	void log(double value);
	void log(float value);	
	void log(long value);	

};

#endif
