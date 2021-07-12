#include  <Servo.h>
#include <SoftwareSerial.h>
  
const int trigPin = 7;
const int echoPin = 6;

long duration;
int distance;

int cmd = -1;
int flag = 0;

Servo myServo;


void setup() {
  pinMode(trigPin, OUTPUT); // set trigPin sebagai output
  pinMode(echoPin, INPUT); // set trigPin sebagai input
  Serial.begin(9600);
  myServo.attach(9); // mendefinisikan pin servo
//  Bluetooth.begin(9600);
  
}


void loop() {
   if (Serial.available() > 0) {
    cmd = Serial.read();
    flag = 1;
  }

  if (flag == 1) {

     if (cmd == 'a'){
      myServo.write(0);
      Serial.println("Rotating to 0");
    }

    else if (cmd == 'b'){
    myServo.write(15);
    Serial.println("Rotating to 15");
    }


    else if (cmd == 'c'){
    myServo.write(30);
    Serial.println("Rotating to 30");
    }

    else if (cmd == 'd'){
    myServo.write(45);
    Serial.println("Rotating to 45");
    }
    
    else if (cmd == 'e'){
    myServo.write(60);
    Serial.println("Rotating to 60");
    }

    else if (cmd == 'f'){
    myServo.write(75);
    Serial.println("Rotating to 75");
    }
    
    else if (cmd == 'g'){
    myServo.write(90);
    Serial.println("Rotating to 90");
    }

    else if (cmd == 'h'){
    myServo.write(105);
    Serial.println("Rotating to 105");
    }
    
    else if (cmd == 'i'){
    myServo.write(120);
    Serial.println("Rotating to 120");
    }

    else if (cmd == 'j'){
    myServo.write(135);
    Serial.println("Rotating to 135");
    }
    
    else if (cmd == 'k'){
    myServo.write(150);
    Serial.println("Rotating to 150");
    }

    else if (cmd == 'l'){
    myServo.write(165);
    Serial.println("Rotating to 165");
    }

    else if (cmd == 'm'){
    myServo.write(180);
    Serial.println("Rotating to 180");
    }
    
    else if (cmd == 'z'){
      
    for(int i=0; i<=180; i++){  // berputar dari 0 derajat ke 180 derajat
    myServo.write(i);
    delay(30);
    distance = calculateDistance();
    
    Serial.print(i); // derajat
    Serial.print(",");
    Serial.print(distance); // jarak
    Serial.print(".");
  }
    Serial.println("");
    Serial.println("Already Scanned");
  
    }

    flag = 0;
    cmd = 65;
  }

//  Serial.flush();
//  delay(100);
}

int calculateDistance(){ 
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Set trigPin HIGH state 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  //kembali waktu tempuh gelombang suara dalam micro seconds
  distance = duration*0.034/2;
  return distance;
}
