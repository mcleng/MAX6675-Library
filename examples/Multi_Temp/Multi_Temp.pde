/*
  Multi_Temp.pde - Example using the MAX6675 Library.
  Created by Ryan McLaughlin <ryanjmclaughlin@gmail.com>
*/

#include <MAX6675.h>

int CS0 = 8;          // CS pin on MAX6675
int CS1 = 9;          // CS pin on MAX6675
int CS2 = 10;         // CS pin on MAX6675
int CS3 = 11;         // CS pin on MAX6675
int SO = 12;          // SO pin of MAX6675
int SCK = 13;         // SCK pin of MAX6675
int units = 0;        // Units to readout temp (0 = ÀöF, 1 = ÀöC)
float error1 = 0.0;   // Temperature compensation error
float error2 = 0.0;   // Temperature compensation error
float error3 = 0.0;   // Temperature compensation error
float error4 = 0.0;   // Temperature compensation error

float temp_read1, temp_read2, temp_read3, temp_read4;

MAX6675 temp1(CS1,SO,SCK,units,error1);
MAX6675 temp2(CS2,SO,SCK,units,error2);
MAX6675 temp3(CS3,SO,SCK,units,error3);
MAX6675 temp4(CS4,SO,SCK,units,error4);

void setup() {
  Serial.begin(9600);
}

void loop() {
  temp_read1 = temp1.read_temp(5);  // Read the temp 5 times and return the average value 
  temp_read2 = temp2.read_temp(5);  // Read the temp 5 times and return the average value 
  temp_read3 = temp3.read_temp(5);  // Read the temp 5 times and return the average value 
  temp_read4 = temp4.read_temp(5);  // Read the temp 5 times and return the average value 
  
  Serial.print(temp_read1);
  Serial.print("  ");
  Serial.print(temp_read2);
  Serial.print("  ");
  Serial.print(temp_read3);
  Serial.print("  ");
  Serial.println(temp_read4);
  Delay(1000);
}
