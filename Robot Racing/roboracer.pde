#include <Ultrasonic.h>
#include <Servo.h>

//Motors
int M1[] = {5, 6};
int M2[] = {9, 10};

//Sensors/Servos
int S1 = 7;
int S2 = 8;
int S3 = 12;
int S4 = 13;
Servo servo1;
//Servo servo2;
//Servo servo3;
//Servo servo4;
int pos;

void setup() {
  Serial.begin(9600);
  // Setup motors
  int i;
  for(i = 0; i < 2; i++) {
    pinMode(M1[i], OUTPUT);
    pinMode(M2[i], OUTPUT);
  }
  // Setup sensors/servos
  pinMode(S1, INPUT);
  pinMode(S2, INPUT);
  pinMode(S3, INPUT);
  //pinMode(S4, INPUT);
  servo1.attach(S4);  
}

void loop () {
  digitalWrite(M1[0], LOW);
  digitalWrite(M1[1], HIGH);
  Serial.println(digitalRead(S1));
  for(pos = 0; pos < 180; pos += 1) {
    servo1.write(pos);
    delay(15);
  }
  for(pos = 180; pos > 0; pos -= 1) {
    servo1.write(pos);
    delay(15);
  }
}
