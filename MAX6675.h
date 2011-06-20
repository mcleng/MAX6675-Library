/*
  MAX6675.h - Library for reading temperature from a MAX6675.
  
  This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License.
  http://creativecommons.org/licenses/by-sa/3.0/
*/

#ifndef MAX6675_h
#define MAX6675_h

#include "WProgram.h"

class MAX6675
{
  public:
    MAX6675(int CS_pin, int SO_pin, int SCK_pin, int units);
    float read_temp();
  private:
    int _CS_pin;
    int _SO_pin;
    int _SCK_pin;
    int _units;
	int chip_read( int CS_pin, int &error_tc ); 
};

#endif
