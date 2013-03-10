// Init String = PORTS_INIT [DataPort],[Port Min],[Port Max]\n
// Data String = PLOT [DataPort],[Series N],[Series Name],[VALUE],[COLOR]\n 
// Debug String = LOG String\n 


import processing.serial.*;
 
Serial myPort;        // The serial port
int index=0;
int maxPorts = 0;
int millisStart = 0;
int lastX = 0;
int dataCount=0;

int[] arrPorts = {};
int[] arrPortsMin = {};
int[] arrPortsMax = {};


final int screenSizeX = 1300, screenSizeY = 740, dataBoxWidth = 160;
final int Xperiod = 50; //Miliseconds


 String[] serialSimulation = {"PORT_INIT 0,-45,45\n",
                               "PORT_INIT 1,-45,45\n",
                               "PORT_INIT 2,0,1000\n",
                               "DATA 0,0,Roll,0,#ff0000\n",
                               "DATA 1,0,Pitch,5,#00ff00\n",
                               "DATA 2,0,Yaw,0,#0000ff\n",
                               "DATA 0,1,Roll Corr,4,#7070ff\n",
                               "DATA 0,0,Roll,1,#ff0000\n",
                               "DATA 1,0,Pitch,7,#00ff00\n",
                               "LOG Hola mundo\n",
                               "DATA 2,0,Yaw,2,#0000ff\n",
                               "DATA 0,0,Roll,2,#ff0000\n",
                               "DATA 0,1,Roll Corr,2,#7070ff\n",
                               "DATA 1,0,Pitch,8,#00ff00\n",
                               "DATA 2,0,Yaw,3,#0000ff\n",
                               "DATA 0,1,Roll Corr,3,#7070ff\n",
                               "DATA 0,0,Roll,0,#ff0000\n",
                               "DATA 1,0,Pitch,7.5,#00ff00\n",
                               "DATA 2,0,Yaw,4,#0000ff\n",
                               "DATA 0,1,Roll Corr,1,#7070ff\n",
                               "DATA 0,0,Roll,-1,#ff0000\n",
                               "DATA 1,0,Pitch,6,#00ff00\n",
                               "DATA 2,0,Yaw,7,#0000ff\n",
                               "DATA 0,1,Roll Corr,-1,#7070ff\n",
                               "DATA 0,1,Roll Corr,2,#7070ff\n",
                               "DATA 2,0,Yaw,9,#0000ff\n",
                               "DATA 2,0,Yaw,11,#0000ff\n",
                               "DATA 2,0,Yaw,9,#0000ff\n"
                               
                             };
 
 void setup () {
   // set the window size:
   size(screenSizeX, screenSizeY);
   
   // List all the available serial ports - Uncomment for live stream
   println(Serial.list());

   
   myPort = new Serial(this, getUSBPort(Serial.list()), 115200);
  
    // don't generate a serialEvent() unless you get a newline character:
   myPort.bufferUntil('\n');   

   millisStart = millis();   

 }
 
 void draw () {
   // everything happens in the serialEvent()
   
   /*
   //For testing caling manualy
   serialEvent(serialSimulation[index]);
   if (index<serialSimulation.length-1) index++;
     else index=3;
     
   */
 }
 

 
//void serialEvent (String inString) { 
void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
 
  inString = trim(inString);
  
//  println("Reading data...");
//  println(inString);
  
  if (match(inString, "PORT_INIT ")!=null) {
//    println("Init ports");
    initScreen(inString.substring(10));
  }
  if (match(inString, "DATA ")!=null) {
//    println("Plotting");
    plot_data(inString.substring(5));
  }
  if (match(inString, "LOG ")!=null) {
    log_data(inString.substring(4));
  }
}

void initScreen(String inString) { 
  String[] initParams = split(inString, ',');
  int dataPort = int(initParams[0]);
  int portMin = int(initParams[1]);
  int portMax = int(initParams[2]);
  
  //Add Port to current arrays
  arrPorts = append(arrPorts, dataPort);
  arrPortsMin = append(arrPortsMin, portMin);
  arrPortsMax = append(arrPortsMax, portMax);
  
  
   background(0);
   int portHeight = screenSizeY / arrPorts.length;

   clearScreenPlots();     
 }   
   
   
void clearScreenPlots() {
    strokeWeight(2);
    rectMode(CORNERS); 
    stroke(color(255,255,255));
    fill(color(30, 30, 30));
  
    int portHeight=0;
    if (arrPorts.length>0) {
      portHeight = screenSizeY / arrPorts.length;    
    } else {
      portHeight = screenSizeY;
    }

    for (int i=0; i<arrPorts.length;i++) {
       rect(0,portHeight*i,screenSizeX,portHeight*i+portHeight);
     }
}

   
void plot_data(String inString) {   
    String[] dataParams = split(inString, ',');
    
    int dataPort    = int(dataParams[0]);
    int seriesNum   = int(dataParams[1]);
    String serieName= dataParams[2];  
    float value     = float(dataParams[3]);
    String setcolor = trim(dataParams[4]);
    
    int portHeight=0;
    printLabels(dataPort, seriesNum, serieName, value, setcolor);    
    
    if (arrPorts.length>0) {
      portHeight = screenSizeY / arrPorts.length;    
    } else {
      portHeight = screenSizeY;
    }
    
    int xOffset = dataBoxWidth;
    int yOffset = dataPort * portHeight; 
    
    int plotX = int((millis()-millisStart) / Xperiod);
    if (plotX>=(screenSizeX-xOffset)) {
      millisStart = millis();
      plotX = 0;
      dataCount = 0;
      clearScreenPlots();
    }
     
    //Plotting....
    
    //Sets color
     colorMode(RGB, 255, 255, 255);
     String newcolor = "FF" + setcolor.substring(1);
     fill(unhex(newcolor));
     
     // Map to graph size
     float plotY = map(value, arrPortsMin[dataPort], arrPortsMax[dataPort], portHeight, 0);
          
     strokeWeight(2);
     stroke(unhex(newcolor));
     point(xOffset + plotX,  yOffset + plotY);
    
 }
 
 
void printLabels(int dataPort, int seriesNun, String seriesName, float value, String setcolor) {
    
     
     int portHeight;
     if (arrPorts.length>0) {
      portHeight = screenSizeY / arrPorts.length;    
    } else {
      portHeight = screenSizeY;
    }
    
         
     int xOffset = dataBoxWidth;
     int yOffset = dataPort * portHeight; 
     

     // Clear values only at bwginning of cycle
     int plotX = int((millis()-millisStart) / Xperiod);
     if (dataCount<=10) {
       // Draw box:
       strokeWeight(2);
       rectMode(CORNERS); 
       stroke(color(255,255,255));
       fill(color(50, 50, 50));
       rect(0,yOffset,dataBoxWidth,yOffset + portHeight);
          
       lastX = plotX ; 
     }
     if (dataCount<=25) {
        // Draw Labels
       colorMode(RGB, 255, 255, 255);
       String newcolor = "FF" + setcolor.substring(1);
       fill(unhex(newcolor));  
       text(seriesName, 10, 20+seriesNun*20 + yOffset);
    
     } 
     
     
     //Clears text
     rectMode(CORNERS); 
     strokeWeight(0);
     stroke(color(50, 50, 50));
     fill(color(50, 50, 50));
     rect(90, yOffset + seriesNun*20 + 5 , dataBoxWidth-2, yOffset + seriesNun*20 + 20 + 5);
         
     //Draw Current values
     colorMode(RGB, 255, 255, 255);
     String newcolor = "FF" + setcolor.substring(1);
     fill(unhex(newcolor));  
     text(value, 90, 20+seriesNun*20 + yOffset);
     
     dataCount++;
} 
 
 
void log_data(String inString) {
    println(inString);

}



float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}


String getUSBPort(String[] lista) {
  String out=""; 
  for (int i=0; i<lista.length;i++) {
     if (match(lista[i], "/dev/tty.usbmodem")!=null) {
       out = lista[i];
     }
  }
  return out;
}


