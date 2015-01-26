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
Sheet 5 5
Title ""
Date "26 jan 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 4950 4150 0    60   ~ 0
Probe
Text HLabel 5050 3950 0    60   Input ~ 0
EC_ProbeIN
Wire Wire Line
	2550 2700 5650 2700
Wire Wire Line
	6350 2800 8850 2800
Wire Wire Line
	5650 2900 5450 2900
Wire Notes Line
	5200 3950 4900 3950
Wire Notes Line
	4900 4600 5250 4600
Wire Notes Line
	5250 4600 5250 3950
Wire Notes Line
	5250 3950 5100 3950
Wire Notes Line
	4900 3950 4900 4600
Wire Notes Line
	5350 4500 4750 4100
Wire Notes Line
	4750 4100 4750 4200
Wire Notes Line
	4750 4100 4850 4100
Wire Wire Line
	5100 5000 5100 4600
Wire Wire Line
	2550 5000 5100 5000
$Comp
L MCP6244 U2
U 2 1 54B66448
P 5900 2800
F 0 "U2" H 6000 3000 60  0000 L CNN
F 1 "MCP6244" H 5950 2600 60  0000 L CNN
F 2 "~" H 6000 2800 60  0000 C CNN
F 3 "~" H 6000 2800 60  0000 C CNN
	2    5900 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 2900 5450 3850
Wire Wire Line
	5450 3850 5050 3850
Wire Wire Line
	5050 3850 5050 3950
Wire Wire Line
	6650 2800 6650 3750
Connection ~ 6650 2800
Wire Wire Line
	6650 3750 6350 3750
Wire Wire Line
	5850 3750 5450 3750
Connection ~ 5450 3750
$Comp
L R R10
U 1 1 54B66458
P 6100 3750
F 0 "R10" V 6180 3750 40  0000 C CNN
F 1 "1K .5%" V 6107 3751 40  0000 C CNN
F 2 "~" V 6030 3750 30  0000 C CNN
F 3 "~" H 6100 3750 30  0000 C CNN
	1    6100 3750
	0    1    -1   0   
$EndComp
Text HLabel 2550 2700 0    60   Input ~ 0
AC_SHRUNK
Text HLabel 2550 5000 0    60   Input ~ 0
VGND
Text HLabel 8850 2800 2    60   Output ~ 0
EC_SIGNAL
$EndSCHEMATC
