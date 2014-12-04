EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:BenchBuddy
LIBS:LettuceBuddy
LIBS:LadyBugShield-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 8
Title ""
Date "4 dec 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R15
U 1 1 540DEB6D
P 3700 3300
F 0 "R15" V 3780 3300 40  0000 C CNN
F 1 "1K  .1%" V 3707 3301 40  0000 C CNN
F 2 "~" V 3630 3300 30  0000 C CNN
F 3 "~" H 3700 3300 30  0000 C CNN
	1    3700 3300
	0    -1   -1   0   
$EndComp
Text HLabel 5300 3300 2    60   Input ~ 0
Therm_IN
Text HLabel 1400 2700 0    60   Output ~ 0
Therm_AIN
Wire Wire Line
	4550 2700 4550 3300
Wire Notes Line
	6000 3100 6000 3500
Wire Notes Line
	6000 3500 5350 3500
Wire Notes Line
	5350 3500 5350 3100
Wire Notes Line
	5350 3100 6000 3100
Text HLabel 1250 1500 0    60   Input ~ 0
V+_WallWart
$Comp
L C C3
U 1 1 544542CF
P 1750 1950
F 0 "C3" H 1750 2050 40  0000 L CNN
F 1 ".1" H 1756 1865 40  0000 L CNN
F 2 "~" H 1788 1800 30  0000 C CNN
F 3 "~" H 1750 1950 60  0000 C CNN
	1    1750 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 1750 1750 1500
Wire Notes Line
	6000 3300 6500 3300
Wire Notes Line
	6500 3300 6500 1500
Text Notes 6700 3000 0    60   ~ 0
Thermistor uses 2 connectors: Therm_IN andV+_WallWartTherm.
Wire Wire Line
	3450 3300 2650 3300
Wire Wire Line
	1400 2700 4550 2700
Wire Wire Line
	1250 1500 6500 1500
Connection ~ 1750 1500
Wire Wire Line
	1750 2150 1750 2300
Wire Wire Line
	1750 2300 1950 2300
Text HLabel 2650 3300 0    60   Output ~ 0
AGND
Text HLabel 1950 2300 2    60   Output ~ 0
AGND
$Comp
L R R9
U 1 1 546CA129
P 4900 3300
F 0 "R9" V 4980 3300 40  0000 C CNN
F 1 "0K" V 4907 3301 40  0000 C CNN
F 2 "~" V 4830 3300 30  0000 C CNN
F 3 "~" H 4900 3300 30  0000 C CNN
	1    4900 3300
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5300 3300 5150 3300
Wire Wire Line
	3950 3300 4650 3300
Connection ~ 4550 3300
$EndSCHEMATC
