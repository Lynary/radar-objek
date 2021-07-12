import processing.serial.*; // import library serial com
import java.awt.event.KeyEvent;
import java.io.IOException;

////import android.bluetooth.BluetoothAdapter;
////import android.bluetooth.BluetoothDevice;
////import android.bluetooth.BluetoothSocket;
////import android.content.Context;
////import android.content.Intent;
////import android.content.IntentFilter;
//import java.util.UUID;
////import android.os.Handler;
////import android.os.Message;
////import java.util.ArrayList;
//import java.io.InputStream;
//import java.io.OutputStream;
//import java.lang.reflect.Method;


Serial myPort; // mendefinisikan serial objek

String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;

void setup() {
  
 size (1200, 700); // Resolusi
 smooth();
 myPort = new Serial(this,"COM9", 9600); // memulai serial com
 myPort.bufferUntil('.');
}

void draw() {

  fill(98,245,31);
  // membuat efek
  noStroke();
  fill(0,4); 
  rect(0, 0, width, height-height*0.065); 
  
  fill(98,245,31);

  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}

void serialEvent (Serial myPort) { // membaca data dari serial port

  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(","); 
  angle= data.substring(0, index1); 
  distance= data.substring(index1+1, data.length()); 
  
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width/2,height-height*0.074); // koordinat
  noFill();
  strokeWeight(3);
  stroke(98,245,31);
  
  // draws the arc lines
  arc(0,0,(width-width*0.062),(width-width*0.062),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.52),(width-width*0.52),PI,TWO_PI);
  arc(0,0,(width-width*0.76),(width-width*0.76),PI,TWO_PI);
  
  //asli
  //arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  //arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  //arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  //arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  
  // angle
  line(-width/2,0,width/2,0);
  line(0,0,(-width/2)*cos(radians(15)),(-width/2)*sin(radians(15)));
  line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
  line(0,0,(-width/2)*cos(radians(45)),(-width/2)*sin(radians(45)));
  line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
  line(0,0,(-width/2)*cos(radians(75)),(-width/2)*sin(radians(75)));
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
  line(0,0,(-width/2)*cos(radians(105)),(-width/2)*sin(radians(105)));
  line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
  line(0,0,(-width/2)*cos(radians(135)),(-width/2)*sin(radians(135)));
  line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
  line(0,0,(-width/2)*cos(radians(165)),(-width/2)*sin(radians(165)));
  line((-width/2)*cos(radians(30)),0,width/2,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width/2,height-height*0.074); // koordinat
  strokeWeight(9);
  stroke(255,10,10);
  pixsDistance = iDistance*((height-height*0.1666)*0.025); // cm ke pixel
  // limit 
  if(iDistance<40){
    // draws the object according to the angle and the distance
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),(width-width*0.505)*cos(radians(iAngle)),-(width-width*0.505)*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(width/2,height-height*0.074); // moves the starting coordinats to new location
  line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle))); // draws the line according to the angle
  popMatrix();
}

void drawText() { // draws the texts on the screen
  
  pushMatrix();
  if(iDistance>40) {
  noObject = "Out of Range";
  }
  else {
  noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, height-height*0.0648, width, height);
  fill(98,245,31);
  textSize(25);
  
  text("10cm",width-width*0.3854,height-height*0.0833);
  text("20cm",width-width*0.281,height-height*0.0833);
  text("30cm",width-width*0.177,height-height*0.0833);
  text("40cm",width-width*0.0729,height-height*0.0833);
  
  textSize(30);
  text("Object: " + noObject, width-width*0.875, height-height*0.0277);
  text("Angle: " + iAngle +" °", width-width*0.48, height-height*0.0277);
  text("Distance: ", width-width*0.26, height-height*0.0277);
  if(iDistance<40) {
  text("           " + iDistance +" cm", width-width*0.225, height-height*0.0277);
  }
  
  textSize(25);
  fill(98,245,60);
  
  translate((width-width*0.513)+width/2*cos(radians(15)),(height-height*0.0907)-width/2*sin(radians(15)));
  text("15°",0,0);
  resetMatrix();
  
  translate((width-width*0.499)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
  text("30°",0,0);
  resetMatrix();
  
  translate((width-width*0.501)+width/2*cos(radians(45)),(height-height*0.0888)-width/2*sin(radians(45)));
  text("45°",0,0);
  resetMatrix();
  
  translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
  text("60°",0,0);
  resetMatrix();
  
  translate((width-width*0.505)+width/2*cos(radians(75)),(height-height*0.0888)-width/2*sin(radians(75)));
  text("75°",0,0);
  resetMatrix();
  
  translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
  text("90°",0,0);
  resetMatrix();
  
  translate((width-width*0.520)+width/2*cos(radians(105)),(height-height*0.0880)-width/2*sin(radians(105)));
  text("105°",0,0);
  resetMatrix();
  
  translate(width-width*0.520+width/2*cos(radians(120)),(height-height*0.0912)-width/2*sin(radians(120)));
  text("120°",0,0);
  resetMatrix();
  
  translate(width-width*0.530+width/2*cos(radians(135)),(height-height*0.0950)-width/2*sin(radians(135)));
  text("135°",0,0);
  resetMatrix();
  
  translate((width-width*0.530)+width/2*cos(radians(150)),(height-height*0.0974)-width/2*sin(radians(150)));
  text("150°",0,0);
  resetMatrix();
  
  translate((width-width*0.513)+width/2*cos(radians(165)),(height-height*0.0974)-width/2*sin(radians(165)));
  text("165°",0,0);
  popMatrix(); 
 
}
