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
Sheet 8 10
Title ""
Date "13 apr 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L DIODE D7
U 1 1 54C7CC9B
P 4850 3300
F 0 "D7" H 4850 3400 40  0000 C CNN
F 1 "DIODE" H 4850 3200 40  0000 C CNN
F 2 "~" H 4850 3300 60  0000 C CNN
F 3 "~" H 4850 3300 60  0000 C CNN
	1    4850 3300
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 54C7CCA1
P 5700 3550
F 0 "C7" H 5700 3650 40  0000 L CNN
F 1 ".1u" H 5706 3465 40  0000 L CNN
F 2 "~" H 5738 3400 30  0000 C CNN
F 3 "~" H 5700 3550 60  0000 C CNN
	1    5700 3550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5700 4350 5700 3750
Wire Wire Line
	2400 3200 3800 3200
$Comp
L MCP6244 U5
U 3 1 54C7CCAB
P 4050 3300
F 0 "U5" H 4150 3500 60  0000 L CNN
F 1 "MCP6244" H 4100 3100 60  0000 L CNN
F 2 "~" H 4150 3300 60  0000 C CNN
F 3 "~" H 4150 3300 60  0000 C CNN
	3    4050 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 3300 4650 3300
Wire Wire Line
	5050 3300 6750 3300
Wire Wire Line
	3700 3850 3700 3400
Wire Wire Line
	3700 3400 3800 3400
Wire Wire Line
	5700 3300 5700 3350
Wire Wire Line
	7450 3400 8450 3400
Wire Wire Line
	6750 3500 6650 3500
Wire Wire Line
	6650 3500 6650 4250
Wire Wire Line
	6650 4250 8150 4250
Text Label 4250 3850 2    60   ~ 0
RVin-
Text Label 4600 3300 2    60   ~ 0
R_Vout
Wire Wire Line
	8150 4250 8150 3400
Connection ~ 8150 3400
Text GLabel 5700 4350 0    60   Input ~ 0
VGND
$Comp
L MCP6244 U5
U 4 1 54C7CCD8
P 7000 3400
F 0 "U5" H 7100 3600 60  0000 L CNN
F 1 "MCP6244" H 7050 3200 60  0000 L CNN
F 2 "~" H 7100 3400 60  0000 C CNN
F 3 "~" H 7100 3400 60  0000 C CNN
	4    7000 3400
	1    0    0    -1  
$EndComp
Text HLabel 2400 3200 0    100  Input ~ 0
Signal
Text HLabel 8450 3400 2    100  Output ~ 0
EC_AIN
Wire Wire Line
	5350 3300 5350 3850
Wire Wire Line
	5350 3850 3700 3850
Connection ~ 5350 3300
Connection ~ 5700 3300
Wire Wire Line
	6350 3500 6350 3300
Connection ~ 6350 3300
Wire Wire Line
	6350 3900 6350 4100
Connection ~ 5700 4100
Wire Wire Line
	6350 4100 5700 4100
Wire Wire Line
	6050 3700 6050 4550
Wire Wire Line
	6050 4550 2450 4550
Text HLabel 2450 4550 0    100  Input ~ 0
FET_pin
$Comp
L LB_MOSFET_N Q4
U 1 1 552BD149
P 6250 3700
F 0 "Q4" H 6260 3870 60  0000 R CNN
F 1 "LB_MOSFET_N" H 6260 3550 60  0000 R CNN
F 2 "~" H 6250 3700 60  0000 C CNN
F 3 "~" H 6250 3700 60  0000 C CNN
	1    6250 3700
	1    0    0    -1  
$EndComp
$EndSCHEMATC
