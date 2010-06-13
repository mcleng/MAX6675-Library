/*
  MAX6675.h - Library for reading temperature from a MAX6675.
  Created by Ryan McLaughlin <ryanjmclaughlin@gmail.com>
*/

#ifndef MAX6675_h
#define MAX6675_h

#include "WProgram.h"

class MAX6675
{
  public:
    MAX6675(int CS_pin, int SO_pin, int SCK_pin, int units, float error);
    float read_temp();
  private:
    int _CS_pin;
    int _SO_pin;
    int _SCK_pin;
    int _units;
    float _error;
};

#endif
