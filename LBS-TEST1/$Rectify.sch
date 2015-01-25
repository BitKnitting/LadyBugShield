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
LIBS:LettuceBuddy
LIBS:LBS-TEST1-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 5
Title ""
Date "24 jan 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L DIODE D3
U 1 1 54B6656F
P 4650 3750
F 0 "D3" H 4650 3850 40  0000 C CNN
F 1 "DIODE" H 4650 3650 40  0000 C CNN
F 2 "~" H 4650 3750 60  0000 C CNN
F 3 "~" H 4650 3750 60  0000 C CNN
	1    4650 3750
	1    0    0    -1  
$EndComp
$Comp
L C C6
U 1 1 54B66575
P 6200 4000
F 0 "C6" H 6200 4100 40  0000 L CNN
F 1 "1u" H 6206 3915 40  0000 L CNN
F 2 "~" H 6238 3850 30  0000 C CNN
F 3 "~" H 6200 4000 60  0000 C CNN
	1    6200 4000
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6200 4800 6200 4200
Wire Wire Line
	2550 3650 3600 3650
Wire Wire Line
	4300 3750 4450 3750
$Comp
L DIODE D4
U 1 1 54B66586
P 5350 3750
F 0 "D4" H 5350 3850 40  0000 C CNN
F 1 "DIODE" H 5350 3650 40  0000 C CNN
F 2 "~" H 5350 3750 60  0000 C CNN
F 3 "~" H 5350 3750 60  0000 C CNN
	1    5350 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 3750 4850 3750
Wire Wire Line
	6550 3750 5550 3750
Wire Wire Line
	5850 3750 5850 4300
Wire Wire Line
	5850 4300 3500 4300
Wire Wire Line
	3500 4300 3500 3850
Wire Wire Line
	3500 3850 3600 3850
Wire Wire Line
	6200 3750 6200 3800
Connection ~ 5850 3750
Connection ~ 6200 3750
Wire Wire Line
	7250 3850 9500 3850
Wire Wire Line
	6550 3950 6450 3950
Wire Wire Line
	6450 3950 6450 4700
Wire Wire Line
	6450 4700 7950 4700
$Comp
L R R9
U 1 1 54B66599
P 5950 2650
F 0 "R9" V 6030 2650 40  0000 C CNN
F 1 "1K" V 5957 2651 40  0000 C CNN
F 2 "~" V 5880 2650 30  0000 C CNN
F 3 "~" H 5950 2650 30  0000 C CNN
	1    5950 2650
	0    1    -1   0   
$EndComp
Wire Wire Line
	7800 2650 6200 2650
Wire Wire Line
	5700 2650 5000 2650
Wire Wire Line
	5000 2650 5000 3750
Connection ~ 5000 3750
Text HLabel 9500 3850 2    60   Output ~ 0
EC_AIN
Text Label 4050 4300 2    60   ~ 0
RVin-
Text Label 4400 3750 2    60   ~ 0
R_Vout
Text Label 5000 3350 2    60   ~ 0
DD
Wire Wire Line
	7800 2650 7800 3850
Connection ~ 7800 3850
Wire Wire Line
	7950 4700 7950 3850
Connection ~ 7950 3850
$Comp
L MCP6244 U2
U 3 1 54B66CD4
P 3850 3750
F 0 "U2" H 3950 3950 60  0000 L CNN
F 1 "MCP6244" H 3900 3550 60  0000 L CNN
F 2 "~" H 3950 3750 60  0000 C CNN
F 3 "~" H 3950 3750 60  0000 C CNN
	3    3850 3750
	1    0    0    -1  
$EndComp
$Comp
L MCP6244 U2
U 4 1 54B66D01
P 6800 3850
F 0 "U2" H 6900 4050 60  0000 L CNN
F 1 "MCP6244" H 6850 3650 60  0000 L CNN
F 2 "~" H 6900 3850 60  0000 C CNN
F 3 "~" H 6900 3850 60  0000 C CNN
	4    6800 3850
	1    0    0    -1  
$EndComp
Text HLabel 2550 3650 0    60   Input ~ 0
EC_SIGNAL
Text HLabel 6200 4800 0    60   Input ~ 0
VGND
$EndSCHEMATC
