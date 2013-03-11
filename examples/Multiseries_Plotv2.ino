
// Include library
#include <PlotterV2.h>

// Define the object
PlotterV2 plot;

void setup() { 
  Serial.begin(115200);

  //Initialize viewports and its limits
  plot.portInit(0,-90,90);
  plot.portInit(1,-90,90);
  plot.portInit(2,0,360);
}

void loop() {
	//Read whatever you want to plot
	int    valueA = .....;
	float  valueB = .....;
	double valueC = .....;
	double valueD = .....;
	
	
	// Viewport 0
	plot.plot(0, 0, "My Value A", valueA, "#900000");  
	
	// Viewport 1
	plot.plot(1, 0, "Value B", valueB, "#009000");
	
	// Viewport 2
	plot.plot(2, 0, "C:",  valueC, "#808080");
	plot.plot(2, 1, "D:", valueD, "#5050f0");    
	
	delay(100);
}
