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
Sheet 6 10
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
L R R3
U 1 1 54C79AB8
P 4650 3750
F 0 "R3" V 4730 3750 40  0000 C CNN
F 1 "1K" V 4657 3751 40  0000 C CNN
F 2 "~" V 4580 3750 30  0000 C CNN
F 3 "~" H 4650 3750 30  0000 C CNN
	1    4650 3750
	0    1    -1   0   
$EndComp
$Comp
L R R4
U 1 1 54C79ABE
P 4800 4950
F 0 "R4" V 4880 4950 40  0000 C CNN
F 1 "10K" V 4807 4951 40  0000 C CNN
F 2 "~" V 4730 4950 30  0000 C CNN
F 3 "~" H 4800 4950 30  0000 C CNN
	1    4800 4950
	0    1    -1   0   
$EndComp
$Comp
L C C2
U 1 1 54C79AC4
P 4700 3150
F 0 "C2" H 4700 3250 40  0000 L CNN
F 1 ".1u" H 4706 3065 40  0000 L CNN
F 2 "~" H 4738 3000 30  0000 C CNN
F 3 "~" H 4700 3150 60  0000 C CNN
	1    4700 3150
	0    1    -1   0   
$EndComp
$Comp
L C C3
U 1 1 54C79ACA
P 6100 5750
F 0 "C3" H 6100 5850 40  0000 L CNN
F 1 ".1u" H 6106 5665 40  0000 L CNN
F 2 "~" H 6138 5600 30  0000 C CNN
F 3 "~" H 6100 5750 60  0000 C CNN
	1    6100 5750
	0    1    -1   0   
$EndComp
$Comp
L DIODE D4
U 1 1 54C79AD0
P 5500 5600
F 0 "D4" H 5500 5700 40  0000 C CNN
F 1 "DIODE" H 5500 5500 40  0000 C CNN
F 2 "~" H 5500 5600 60  0000 C CNN
F 3 "~" H 5500 5600 60  0000 C CNN
	1    5500 5600
	-1   0    0    -1  
$EndComp
$Comp
L DIODE D6
U 1 1 54C79AD6
P 5500 5900
F 0 "D6" H 5500 6000 40  0000 C CNN
F 1 "DIODE" H 5500 5800 40  0000 C CNN
F 2 "~" H 5500 5900 60  0000 C CNN
F 3 "~" H 5500 5900 60  0000 C CNN
	1    5500 5900
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 54C79ADC
P 6450 3450
F 0 "C5" H 6450 3550 40  0000 L CNN
F 1 ".1u" H 6456 3365 40  0000 L CNN
F 2 "~" H 6488 3300 30  0000 C CNN
F 3 "~" H 6450 3450 60  0000 C CNN
	1    6450 3450
	1    0    0    1   
$EndComp
$Comp
L R R13
U 1 1 54C79AE2
P 6050 3150
F 0 "R13" V 6130 3150 40  0000 C CNN
F 1 "1K" V 6057 3151 40  0000 C CNN
F 2 "~" V 5980 3150 30  0000 C CNN
F 3 "~" H 6050 3150 30  0000 C CNN
	1    6050 3150
	0    1    -1   0   
$EndComp
$Comp
L R R14
U 1 1 54C79AE8
P 6900 3850
F 0 "R14" V 7000 3850 40  0000 C CNN
F 1 "10K" V 6907 3851 40  0000 C CNN
F 2 "~" V 6830 3850 30  0000 C CNN
F 3 "~" H 6900 3850 30  0000 C CNN
	1    6900 3850
	0    1    -1   0   
$EndComp
Text Notes 4850 2850 0    60   ~ 0
Wien Bridge Oscillator\nVpp is about 1V Vpp
Text Notes 7100 2600 0    60   ~ 0
Shrink Signal to about 500mV Vpp
Wire Wire Line
	5250 5600 5300 5600
Wire Wire Line
	5250 5600 5250 5900
Wire Wire Line
	5250 5900 5300 5900
Wire Wire Line
	5700 5600 5750 5600
Wire Wire Line
	5750 5600 5750 5900
Wire Wire Line
	5750 5900 5700 5900
Wire Wire Line
	4550 4950 4400 4950
Wire Wire Line
	6650 3850 6100 3850
Wire Wire Line
	5150 3950 5150 5750
Wire Wire Line
	5150 3950 5400 3950
Wire Wire Line
	5050 4950 5150 4950
Connection ~ 5150 4950
Wire Wire Line
	4400 4950 4400 5300
Wire Wire Line
	7150 3850 8400 3850
$Comp
L MCP6244 U5
U 2 1 54C79AFF
P 5650 3850
F 0 "U5" H 5750 4050 60  0000 L CNN
F 1 "MCP6244" H 5700 3650 60  0000 L CNN
F 2 "~" H 5750 3850 60  0000 C CNN
F 3 "~" H 5750 3850 60  0000 C CNN
	2    5650 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 3150 6450 3150
Wire Wire Line
	6450 3150 6450 3250
Wire Wire Line
	6450 3650 6450 3850
Connection ~ 6450 3850
Wire Wire Line
	6400 3850 6400 5750
Connection ~ 6400 3850
Wire Wire Line
	5150 5750 5250 5750
Connection ~ 5250 5750
Wire Wire Line
	5750 5750 5900 5750
Connection ~ 5750 5750
Wire Wire Line
	6400 5750 6300 5750
Text Label 6400 4600 2    60   ~ 0
W_Vout
Text Label 5150 4700 2    60   ~ 0
W_Vin-
Text Label 5350 3750 2    60   ~ 0
W_Vin+
Text Label 6450 3150 2    60   ~ 0
f1
Text Label 5850 5750 2    60   ~ 0
G1
Wire Wire Line
	4500 3150 4350 3150
Wire Wire Line
	4350 3150 4350 3750
Wire Wire Line
	4350 3750 4400 3750
Wire Wire Line
	5800 3150 4900 3150
Wire Wire Line
	5400 3750 4900 3750
Wire Wire Line
	5100 3150 5100 3750
Connection ~ 5100 3750
Connection ~ 5100 3150
Wire Wire Line
	4350 4000 4200 4000
Wire Wire Line
	4200 4000 4200 3500
Wire Wire Line
	4200 3500 4350 3500
Connection ~ 4350 3500
Wire Wire Line
	7450 2700 7000 2700
Wire Wire Line
	6400 4850 6050 4850
Connection ~ 6400 4850
Wire Wire Line
	5550 4850 5150 4850
Connection ~ 5150 4850
Wire Wire Line
	7450 2900 7450 2700
$Comp
L R R12
U 1 1 54C79B28
P 5800 4850
F 0 "R12" V 5880 4850 40  0000 C CNN
F 1 "22K" V 5807 4851 40  0000 C CNN
F 2 "~" V 5730 4850 30  0000 C CNN
F 3 "~" H 5800 4850 30  0000 C CNN
	1    5800 4850
	0    1    -1   0   
$EndComp
$Comp
L R R16
U 1 1 54C79B2E
P 7450 3150
F 0 "R16" V 7530 3150 40  0000 C CNN
F 1 "10K" V 7457 3151 40  0000 C CNN
F 2 "~" V 7380 3150 30  0000 C CNN
F 3 "~" H 7450 3150 30  0000 C CNN
	1    7450 3150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7450 3400 7450 3850
Connection ~ 7450 3850
Text GLabel 7000 2700 0    60   Input ~ 0
VGND
Text GLabel 4400 5300 2    60   Input ~ 0
VGND
Text GLabel 4350 4000 2    60   Input ~ 0
VGND
Text HLabel 8400 3850 2    60   Output ~ 0
EC_Vin
$EndSCHEMATC
