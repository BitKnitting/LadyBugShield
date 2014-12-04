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
Sheet 7 8
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
L C C12
U 1 1 53DB8C11
P 6800 3750
F 0 "C12" H 6800 3850 40  0000 L CNN
F 1 "10u" H 6806 3665 40  0000 L CNN
F 2 "~" H 6838 3600 30  0000 C CNN
F 3 "~" H 6800 3750 60  0000 C CNN
	1    6800 3750
	1    0    0    -1  
$EndComp
$Comp
L C C13
U 1 1 53DB8C1F
P 7200 3750
F 0 "C13" H 7200 3850 40  0000 L CNN
F 1 ".1u" H 7206 3665 40  0000 L CNN
F 2 "~" H 7238 3600 30  0000 C CNN
F 3 "~" H 7200 3750 60  0000 C CNN
	1    7200 3750
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 53DB8C26
P 4750 3750
F 0 "C11" H 4750 3850 40  0000 L CNN
F 1 "1u" H 4756 3665 40  0000 L CNN
F 2 "~" H 4788 3600 30  0000 C CNN
F 3 "~" H 4750 3750 60  0000 C CNN
	1    4750 3750
	1    0    0    -1  
$EndComp
Text HLabel 10050 3300 2    60   Output ~ 0
V+_WallWart
$Comp
L LED D3
U 1 1 540ED65C
P 7700 3700
F 0 "D3" H 7700 3800 50  0000 C CNN
F 1 "LED" H 7700 3600 50  0000 C CNN
F 2 "~" H 7700 3700 60  0000 C CNN
F 3 "~" H 7700 3700 60  0000 C CNN
	1    7700 3700
	0    1    1    0   
$EndComp
$Comp
L R R5
U 1 1 540EDC27
P 7700 4400
F 0 "R5" V 7780 4400 40  0000 C CNN
F 1 "1K" V 7707 4401 40  0000 C CNN
F 2 "~" V 7630 4400 30  0000 C CNN
F 3 "~" H 7700 4400 30  0000 C CNN
	1    7700 4400
	-1   0    0    1   
$EndComp
Wire Wire Line
	5600 4100 5600 3750
Wire Wire Line
	2850 4100 7200 4100
Wire Wire Line
	7200 4100 7200 3950
Wire Wire Line
	6800 3950 6800 4100
Connection ~ 6800 4100
Wire Wire Line
	4750 4100 4750 3950
Connection ~ 5600 4100
Connection ~ 4750 4100
Wire Wire Line
	6800 3300 6800 3550
Wire Wire Line
	2850 3300 5000 3300
Wire Wire Line
	4750 3550 4750 3300
Connection ~ 4750 3300
Wire Wire Line
	6250 3300 10050 3300
Wire Wire Line
	7200 3300 7200 3550
Connection ~ 6800 3300
Connection ~ 7200 3300
Wire Wire Line
	7700 3900 7700 4150
Wire Wire Line
	7700 4650 7700 4900
$Comp
L MC78L05 U3
U 1 1 54412DB6
P 5600 3500
F 0 "U3" H 5750 3500 60  0000 C CNN
F 1 "MC78L05" H 5600 3950 60  0000 C CNN
F 2 "~" H 5600 3500 60  0000 C CNN
F 3 "~" H 5600 3500 60  0000 C CNN
	1    5600 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 3500 7700 3300
Connection ~ 7700 3300
$Comp
L R R?
U 1 1 547DEB21
P 5400 5800
F 0 "R?" V 5480 5800 40  0000 C CNN
F 1 "1K" V 5407 5801 40  0000 C CNN
F 2 "~" V 5330 5800 30  0000 C CNN
F 3 "~" H 5400 5800 30  0000 C CNN
	1    5400 5800
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 547DEB27
P 5400 6650
F 0 "R?" V 5480 6650 40  0000 C CNN
F 1 "1K" V 5407 6651 40  0000 C CNN
F 2 "~" V 5330 6650 30  0000 C CNN
F 3 "~" H 5400 6650 30  0000 C CNN
	1    5400 6650
	1    0    0    -1  
$EndComp
Text HLabel 5550 5350 2    60   Input ~ 0
V+_WallWart
$Comp
L AGND #PWR?
U 1 1 547DEB2E
P 5400 7150
F 0 "#PWR?" H 5400 7150 40  0001 C CNN
F 1 "AGND" H 5400 7080 50  0000 C CNN
F 2 "" H 5400 7150 60  0000 C CNN
F 3 "" H 5400 7150 60  0000 C CNN
	1    5400 7150
	1    0    0    -1  
$EndComp
Text HLabel 3400 6350 0    60   Output ~ 0
VGND
Text Notes 4850 5150 2    98   ~ 0
Raise GND
Wire Wire Line
	5400 5350 5400 5550
Wire Wire Line
	5400 6900 5400 7150
Wire Wire Line
	5400 6050 5400 6400
Wire Wire Line
	4700 6250 5400 6250
Connection ~ 5400 6250
Wire Wire Line
	4700 6450 5000 6450
Wire Wire Line
	5000 6450 5000 7050
Wire Wire Line
	5000 7050 3700 7050
Wire Wire Line
	3700 7050 3700 6350
Wire Wire Line
	3400 6350 4000 6350
Connection ~ 3700 6350
Wire Notes Line
	2850 5000 6250 5000
Wire Notes Line
	6250 5000 6250 7300
Wire Notes Line
	6250 7300 2850 7300
Wire Notes Line
	2850 7300 2850 5000
Wire Wire Line
	5550 5350 5400 5350
Text HLabel 4600 5250 2    60   Input ~ 0
V+_WallWart
Wire Wire Line
	4450 5250 4450 6050
Wire Wire Line
	4600 5250 4450 5250
$Comp
L AGND #PWR?
U 1 1 547DEB49
P 4450 6850
F 0 "#PWR?" H 4450 6850 40  0001 C CNN
F 1 "AGND" H 4450 6780 50  0000 C CNN
F 2 "" H 4450 6850 60  0000 C CNN
F 3 "" H 4450 6850 60  0000 C CNN
	1    4450 6850
	1    0    0    -1  
$EndComp
$Comp
L MCP6244 U?
U 1 1 547DEB4F
P 4450 6350
AR Path="/547DE5B0/547DEB4F" Ref="U?"  Part="1" 
AR Path="/547DE6F9/547DEB4F" Ref="U?"  Part="1" 
F 0 "U?" H 4550 6550 60  0000 L CNN
F 1 "MCP6244" H 4500 6150 60  0000 L CNN
F 2 "~" H 4550 6350 60  0000 C CNN
F 3 "~" H 4550 6350 60  0000 C CNN
	1    4450 6350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4450 6650 4450 6850
$Comp
L C C?
U 1 1 547DEB56
P 4150 5750
F 0 "C?" H 4150 5850 40  0000 L CNN
F 1 ".1u" H 4156 5665 40  0000 L CNN
F 2 "~" H 4188 5600 30  0000 C CNN
F 3 "~" H 4150 5750 60  0000 C CNN
	1    4150 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 5550 4450 5550
Connection ~ 4450 5550
Wire Wire Line
	4150 5950 4150 6050
$Comp
L AGND #PWR?
U 1 1 547DEB5F
P 4150 6050
F 0 "#PWR?" H 4150 6050 40  0001 C CNN
F 1 "AGND" H 4150 5980 50  0000 C CNN
F 2 "" H 4150 6050 60  0000 C CNN
F 3 "" H 4150 6050 60  0000 C CNN
	1    4150 6050
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 547DEB65
P 5150 5650
F 0 "C?" H 5150 5750 40  0000 L CNN
F 1 ".1u" H 5156 5565 40  0000 L CNN
F 2 "~" H 5188 5500 30  0000 C CNN
F 3 "~" H 5150 5650 60  0000 C CNN
	1    5150 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 5450 5400 5450
Connection ~ 5400 5450
Wire Wire Line
	5150 5950 5150 5850
$Comp
L AGND #PWR?
U 1 1 547DEB6E
P 5150 5950
F 0 "#PWR?" H 5150 5950 40  0001 C CNN
F 1 "AGND" H 5150 5880 50  0000 C CNN
F 2 "" H 5150 5950 60  0000 C CNN
F 3 "" H 5150 5950 60  0000 C CNN
	1    5150 5950
	1    0    0    -1  
$EndComp
Text Label 5050 6250 0    60   ~ 0
pin 3
Text HLabel 3550 6000 0    60   Output ~ 0
AGND
Wire Wire Line
	3550 6000 4150 6000
Connection ~ 4150 6000
Text HLabel 4200 6800 0    60   Output ~ 0
AGND
Wire Wire Line
	4200 6800 4450 6800
Connection ~ 4450 6800
Text HLabel 5000 5900 0    60   Output ~ 0
AGND
Wire Wire Line
	5000 5900 5150 5900
Connection ~ 5150 5900
Text HLabel 5200 7100 0    60   Output ~ 0
AGND
Wire Wire Line
	5200 7100 5400 7100
Connection ~ 5400 7100
Text HLabel 2850 3300 0    60   Input ~ 0
Vin
Text HLabel 2850 4100 0    60   Input ~ 0
GND_ARD
Text Notes 2700 4450 0    60   ~ 0
For discussion (see pdf on ground planes)
Text HLabel 7500 5100 0    60   Output ~ 0
AGND
Wire Wire Line
	7500 5100 7700 5100
Wire Wire Line
	7700 5100 7700 4900
Connection ~ 5250 4100
$EndSCHEMATC
