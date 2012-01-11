#include <Ultrasonic.h>

//Outputs
int motor_left[] = {5, 6};
int motor_right[] = {10, 11};
int sound[] = {2, 3};

//Inputs
int front, left, right = 0;
int infrared[] = {12, 13}; //{left, right}, obstacle = LOW, clear = HIGH
Ultrasonic ultra(7, 8);
int ultralim = 20;

void setup() {
  Serial.begin(9600);
  // Setup motors
  int i;
  for(i = 0; i < 2; i++) {
    pinMode(motor_left[i], OUTPUT);
    pinMode(motor_right[i], OUTPUT);
  }
  pinMode(infrared[0], INPUT);
  pinMode(infrared[1], INPUT);
}

void loop() {
  front = ultra.Ranging(CM);
  left = digitalRead(infrared[0]);
  right = digitalRead(infrared[1]);
  
  if (left == LOW) {
    drive_forward();
    Serial.println("Driving...");
    if (front < ultralim) {
      motor_stop();
      right90();
      delay(500);
      Serial.println("Turn right");
      talk();
    }
  }
  
  else {
    if (front < ultralim) {
      motor_stop();
      drive_backward();
      delay(250);
      motor_stop();
      right90();
      shutup();
    }
    
    else {
      drive_forward();
      delay(800);
      motor_stop();
      left90();
      Serial.println("Turn left");
      drive_forward();
      talk();
      delay(1500);
      motor_stop();
      Serial.println("Drive for a bit");
    }
    delay(500);
    shutup();
  }
}


void right90() {
  turn_right();
  delay(750);
  motor_stop();
}

void left90() {
  turn_left();
  delay(750);
  motor_stop();
}

void talk() {
  digitalWrite(sound[0], LOW);
  digitalWrite(sound[1], HIGH);
}

void shutup() {
  digitalWrite(sound[1], LOW);
  digitalWrite(sound[0], HIGH);
}

void motor_stop() {
  digitalWrite(motor_left[0], LOW);
  digitalWrite(motor_left[1], LOW);

  digitalWrite(motor_right[0], LOW);
  digitalWrite(motor_right[1], LOW);
  delay(25);
}

void drive_forward() {
  digitalWrite(motor_left[0], HIGH);
  digitalWrite(motor_left[1], LOW);

  digitalWrite(motor_right[0], HIGH);
  digitalWrite(motor_right[1], LOW);
}

void drive_backward() {
  digitalWrite(motor_left[0], LOW);
  digitalWrite(motor_left[1], HIGH);

  digitalWrite(motor_right[0], LOW);
  digitalWrite(motor_right[1], HIGH);
}

void turn_left() {
  digitalWrite(motor_left[0], LOW);
  digitalWrite(motor_left[1], HIGH);

  digitalWrite(motor_right[0], HIGH);
  digitalWrite(motor_right[1], LOW);
}

void turn_right(){
  digitalWrite(motor_left[0], HIGH);
  digitalWrite(motor_left[1], LOW);

  digitalWrite(motor_right[0], LOW);
  digitalWrite(motor_right[1], HIGH);
}
