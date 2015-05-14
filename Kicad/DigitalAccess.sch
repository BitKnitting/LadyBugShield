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
Sheet 3 10
Title ""
Date "13 apr 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 2400 3000 0    60   Input ~ 0
SCL
Text HLabel 2400 3150 0    60   BiDi ~ 0
SDA
$Comp
L R R6
U 1 1 5463DA53
P 3200 2400
F 0 "R6" V 3280 2400 40  0000 C CNN
F 1 "10K" V 3207 2401 40  0000 C CNN
F 2 "~" V 3130 2400 30  0000 C CNN
F 3 "~" H 3200 2400 30  0000 C CNN
	1    3200 2400
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 5463DA60
P 3550 2400
F 0 "R7" V 3630 2400 40  0000 C CNN
F 1 "10K" V 3557 2401 40  0000 C CNN
F 2 "~" V 3480 2400 30  0000 C CNN
F 3 "~" H 3550 2400 30  0000 C CNN
	1    3550 2400
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 546637F5
P 5700 2500
F 0 "C1" H 5700 2600 40  0000 L CNN
F 1 ".1u" H 5706 2415 40  0000 L CNN
F 2 "~" H 5738 2350 30  0000 C CNN
F 3 "~" H 5700 2500 60  0000 C CNN
	1    5700 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 3650 3850 4050
Wire Wire Line
	2400 2100 5700 2100
Wire Wire Line
	3550 2100 3550 2150
Wire Wire Line
	3200 2150 3200 2100
Connection ~ 3200 2100
Wire Wire Line
	2400 3000 3850 3000
Wire Wire Line
	3550 2650 3550 3000
Connection ~ 3550 3000
Wire Wire Line
	3850 3150 2400 3150
$Comp
L ADS1015 U4
U 1 1 54804BC7
P 4550 3300
F 0 "U4" H 4750 3850 60  0000 L CNN
F 1 "ADS1015" H 4700 2750 60  0000 L CNN
F 2 "" H 4550 3300 60  0000 C CNN
F 3 "" H 4550 3300 60  0000 C CNN
	1    4550 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 3800 3700 3800
Wire Wire Line
	3700 3800 3700 3500
Wire Wire Line
	3700 3500 3850 3500
Connection ~ 3850 3800
Wire Wire Line
	3200 2650 3200 3150
Connection ~ 3200 3150
Wire Wire Line
	5250 2100 5250 2950
Connection ~ 3550 2100
Wire Wire Line
	3850 4050 3550 4050
Text HLabel 6000 3150 2    60   Input ~ 0
pH_AIN
Text HLabel 6000 3300 2    60   Input ~ 0
EC_AIN
Wire Wire Line
	5250 3150 6000 3150
Wire Wire Line
	5250 3300 6000 3300
Wire Wire Line
	5250 3600 6000 3600
Wire Wire Line
	5700 2100 5700 2300
Connection ~ 5250 2100
Text GLabel 6000 3600 2    60   Input ~ 0
VGND
Text GLabel 3550 4050 0    60   Output ~ 0
GND
Text GLabel 5800 2800 2    60   Output ~ 0
GND
Wire Wire Line
	5700 2700 5700 2800
Wire Wire Line
	5700 2800 5800 2800
Text GLabel 2400 2100 0    60   Input ~ 0
Vclean
$EndSCHEMATC
