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
Sheet 3 8
Title ""
Date "4 dec 2014"
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
L R 10K
U 1 1 5463DA60
P 3550 2400
F 0 "10K" V 3630 2400 40  0000 C CNN
F 1 "3K" V 3557 2401 40  0000 C CNN
F 2 "~" V 3480 2400 30  0000 C CNN
F 3 "~" H 3550 2400 30  0000 C CNN
	1    3550 2400
	1    0    0    -1  
$EndComp
Text HLabel 2400 2100 0    60   Input ~ 0
V+_WallWart
$Comp
L C C1
U 1 1 546637F5
P 5250 2450
F 0 "C1" H 5250 2550 40  0000 L CNN
F 1 ".1u" H 5256 2365 40  0000 L CNN
F 2 "~" H 5288 2300 30  0000 C CNN
F 3 "~" H 5250 2450 60  0000 C CNN
	1    5250 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 3650 3850 4050
Wire Wire Line
	2400 2100 5250 2100
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
L ADS1015 U?
U 1 1 54804BC7
P 4550 3300
F 0 "U?" H 4750 3850 60  0000 L CNN
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
	3850 3300 2400 3300
Text HLabel 2400 3300 0    60   Output ~ 0
ALERT
Wire Wire Line
	3200 2650 3200 3150
Connection ~ 3200 3150
Wire Wire Line
	5250 2950 5250 2650
Wire Wire Line
	5250 2100 5250 2250
Connection ~ 3550 2100
Text HLabel 3550 4050 0    60   Output ~ 0
AGND
Wire Wire Line
	3850 4050 3550 4050
Text HLabel 7100 2900 2    60   Input ~ 0
pH_AIN
Text HLabel 7100 3150 2    60   Input ~ 0
EC_AIN
Text HLabel 7150 3450 2    60   Input ~ 0
Therm_AIN
Text HLabel 7200 3750 2    60   Input ~ 0
VGND
Text Notes 8200 2050 2    60   ~ 0
TBD: MUX to switch between pH and  Thermistor AIN
Text HLabel 7050 4200 2    60   Input ~ 0
Measure_pH_or_Temp
$EndSCHEMATC
