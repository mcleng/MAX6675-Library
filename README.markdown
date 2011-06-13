MAX6675 Arduino Library
=======================

> Version 1.1
> 
> Developed By:
>> Ryan McLaughlin <ryan@ryanjmclaughlin.com>

Summary
-------

The primary use of the library is to easily interface with a MAX6675 chip via it's SPI interface.  Use the following code to initialize the library.

	MAX6675 temp0(CS0,SO,SCK,units,error);
	
Following this you can use the _read_temp()_ function to return the temperature.

	temperature = temp0.read_temp(5);
	