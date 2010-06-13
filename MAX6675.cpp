/*
  MAX6675.cpp - Library for reading temperature from a MAX6675.
  Created by Ryan McLaughlin <ryanjmclaughlin@gmail.com>
*/

#include <WProgram.h>
#include <MAX6675.h>

MAX6675::MAX6675(int CS_pin, int SO_pin, int SCK_pin, int units, float error)
{
  pinMode(CS_pin, OUTPUT);
  pinMode(SO_pin, INPUT);
  pinMode(SCK_pin, OUTPUT);
  
  digitalWrite(CS_pin, HIGH);
  
  _CS_pin = CS_pin;
  _SO_pin = SO_pin;
  _SCK_pin = SCK_pin;
  _units = units;
  _error = error;
}

float MAX6675::read_temp(int samples)
{
  int value = 0;
  int error_tc = 0;
  float temp = 0;
	
  digitalWrite(_CS_pin,LOW); // Enable device

  /* Cycle the clock for dummy bit 15 */
  digitalWrite(_SCK_pin,HIGH);
  digitalWrite(_SCK_pin,LOW);

  /* Read bits 14-3 from MAX6675 for the Temp 
     Loop for each bit reading the value and 
     storing the final value in 'value' 
  */
  for (int j=11; j>=0; j--){
    digitalWrite(_SCK_pin,HIGH);  // Set Clock to HIGH
    value += digitalRead(_SO_pin) << j;  // Read data and add it to our variable
    digitalWrite(_SCK_pin,LOW);  // Set Clock to LOW
  }
  
  /* Read the TC Input input to check for TC Errors */
  digitalWrite(_SCK_pin,HIGH); // Set Clock to HIGH
  error_tc = digitalRead(_SO_pin); // Read data
  digitalWrite(_SCK_pin,LOW);  // Set Clock to LOW
  
  digitalWrite(_CS_pin, HIGH); //Disable Device
  
  value = value/samples;  // Divide the value by the number of samples to get the average
  
  /* 
     Keep in mind that the temp that was just read is on the digital scale
     from 0˚C to 1023.75˚C at a resolution of 2^12.  We now need to convert
     to an actual readable temperature (this drove me nuts until I figured 
     this out!).  Now multiply by 0.25.  I tried to avoid float math but
     it is tough to do a good conversion to ˚F.  THe final value is converted 
     to an int and returned at x10 power.
     
   */
   
  value = value + _error;						// Insert the calibration error value
  
  if(_units == 0) {								// Request temp in ˚F
    temp = ((value*0.25) * (9.0/5.0)) + 32.0;	// Convert value to ˚F (ensure proper floats!)
  } else if(_units == 1) {						// Request temp in ˚C
    temp = (value*0.25);						// Multiply the value by 0.25 to get temp in ˚C
  }
  
  /* Output -1 if there is a TC error, otherwise return 'temp' */
  if(error_tc != 0) {
    return -1; 
  } else { 
    return temp; 
  }
}
