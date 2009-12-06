/*
  Multi_Temp.pde - Example using the MAX6675 Library.
  Created by Ryan McLaughlin <ryanjmclaughlin@gmail.com>
*/

#include <MAX6675.h>

int LED1 = 6;		// Status LED Pin
int CS0 = 7;		// CS pin on MAX6675
int CS1 = 8;		// CS pin on MAX6675
int CS2 = 9;		// CS pin on MAX6675
int CS3 = 10;		// CS pin on MAX6675
int SO = 12;		// SO pin of MAX6675
int SCK = 13;		// SCK pin of MAX6675
int units = 0;		// Units to readout temp (0 = ˚F, 1 = ˚C)
float error1 = 0.0;	// Temperature compensation error
float error2 = 0.0;	// Temperature compensation error
float error3 = 0.0;	// Temperature compensation error
float error4 = 0.0;	// Temperature compensation error
int status = 0;		// Varible to control the status led

float temp[4];


MAX6675 temp0(CS0,SO,SCK,units,error1);
MAX6675 temp1(CS1,SO,SCK,units,error2);
MAX6675 temp2(CS2,SO,SCK,units,error3);
MAX6675 temp3(CS3,SO,SCK,units,error4);


// Setup Serial output and LED Pin  
// MAX6675 Library already sets pin modes for MAX6675 chip!

void setup() {
	Serial.begin(9600);
	pinMode(LED1, OUTPUT);
}


void loop() {
  temp[0] = temp0.read_temp(5);		// Read the temp 5 times and return the average value 
  temp[1] = temp1.read_temp(5);		// Read the temp 5 times and return the average value 
  temp[2] = temp2.read_temp(5);		// Read the temp 5 times and return the average value 
  temp[3] = temp3.read_temp(5);		// Read the temp 5 times and return the average value 
  
    Serial.print("Temperature: \t");	// Print Header to Serial
  for (int i=0; i<4; i++){	 // Loop through each of the four temps
    status = 0;			 // Reset the status to 0 before we check for errors
    if(temp[i] == -1) {		 // If there is an error with the TC, temperature will be -1
      Serial.print("ERROR!");	 // Temperature is -1 and there is a thermocouple error
        status++;		 // Add to the status varible so status LED turns on
    } else {
      Serial.print( temp[i] );   // Print the temperature to Serial
    }
    Serial.print("\t");	         // Print a tab to demininate the data
  }
	
  if(status > 0) {               // Check if we should turn on the status LED
    digitalWrite(LED1, HIGH);    // Turn on the status LED
  } else {
    digitalWrite(LED1, LOW);     // Turn off the status LED
  }
  Serial.println(" ");

  delay(1000);    // Wait one second before reading again
}
