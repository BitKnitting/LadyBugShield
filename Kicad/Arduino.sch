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
Sheet 2 8
Title ""
Date "4 dec 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 2500 2450 0    60   Output ~ 0
V+_ARD
Wire Wire Line
	3550 2450 2500 2450
$Comp
L ARDUINOPINS ARD1
U 1 1 53E0F48C
P 4650 3150
F 0 "ARD1" H 4000 4750 60  0000 C CNN
F 1 "ARDUINOPINS" H 4150 4950 60  0000 C CNN
F 2 "~" H 5200 2200 60  0000 C CNN
F 3 "~" H 5200 2200 60  0000 C CNN
	1    4650 3150
	1    0    0    -1  
$EndComp
Text HLabel 2500 2650 0    60   Input ~ 0
GND_ARD
Wire Wire Line
	2500 2650 3550 2650
Wire Wire Line
	6800 3800 5750 3800
Wire Wire Line
	3550 2850 3200 2850
Wire Wire Line
	3200 2850 3200 2650
Connection ~ 3200 2650
Text HLabel 2900 4350 0    60   BiDi ~ 0
SDA
Wire Wire Line
	2900 4350 3550 4350
Text HLabel 2900 4550 0    60   Output ~ 0
SCL
Wire Wire Line
	2900 4550 3550 4550
Text HLabel 6800 3800 2    59   Output ~ 0
Pump2
Text HLabel 6800 4000 2    59   Output ~ 0
Pump1
Wire Wire Line
	6800 4000 5750 4000
Text HLabel 6800 3600 2    59   Output ~ 0
Pump3
Wire Wire Line
	5750 3600 6800 3600
Text HLabel 6800 3400 2    59   Input ~ 0
ALERT
Wire Wire Line
	6800 3400 5750 3400
Text HLabel 2450 3050 0    60   Output ~ 0
Vin
Wire Wire Line
	3550 3050 2450 3050
Text HLabel 6800 3200 2    60   Output ~ 0
Measure_pH_or_Temp
Wire Wire Line
	5750 3200 6800 3200
$EndSCHEMATC
