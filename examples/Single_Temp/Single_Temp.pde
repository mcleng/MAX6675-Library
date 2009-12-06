/*
  Single_Temp.pde - Example using the MAX6675 Library.
  Created by Ryan McLaughlin <ryanjmclaughlin@gmail.com>
*/

#include <MAX6675.h>

int LED1 = 9;             // Status LED Pin
int CS = 10;              // CS pin on MAX6675
int SO = 12;              // SO pin of MAX6675
int SCK = 13;             // SCK pin of MAX6675
int units = 0;            // Units to readout temp (0 = ˚F, 1 = ˚C)
float error = 0.0;        // Temperature compensation error
float temperature = 0.0;  // Temperature output variable


// Initialize the MAX6675 Library for our chip

MAX6675 temp0(CS0,SO,SCK,units,error);


// Setup Serial output and LED Pin  
// MAX6675 Library already sets pin modes for MAX6675 chip!

void setup() {
  Serial.begin(9600);
  pinMode(LED1, OUTPUT);
}

void loop() {
  temperature = temp0.read_temp(5);         // Read the temp 5 times and return the average value to the var

  if(temperature == -1) {                   // If there is an error with the TC, temperature will be -1
    Serial.println("Thermocouple Error!!"); // Temperature is -1 and there is a thermocouple error
    digitalWrite(LED1, HIGH);               // Turn on the status LED
  } else {
    Serial.print("Current Temperature: ");
    Serial.println( temperature );          // Print the temperature to Serial 
    digitalWrite(LED1, LOW);                // Turn on the status LED
  }
  	
  delay(1000);	// Wait one second before reading again
}
