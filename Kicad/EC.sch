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
Sheet 5 8
Title ""
Date "18 dec 2014"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R19
U 1 1 5416D6EF
P 10500 2200
F 0 "R19" V 10580 2200 40  0000 C CNN
F 1 "1K" V 10507 2201 40  0000 C CNN
F 2 "~" V 10430 2200 30  0000 C CNN
F 3 "~" H 10500 2200 30  0000 C CNN
	1    10500 2200
	0    -1   -1   0   
$EndComp
$Comp
L R R16
U 1 1 5416D6F5
P 10350 3400
F 0 "R16" V 10430 3400 40  0000 C CNN
F 1 "10K" V 10357 3401 40  0000 C CNN
F 2 "~" V 10280 3400 30  0000 C CNN
F 3 "~" H 10350 3400 30  0000 C CNN
	1    10350 3400
	0    -1   -1   0   
$EndComp
$Comp
L C C7
U 1 1 5416D6FD
P 10450 1600
F 0 "C7" H 10450 1700 40  0000 L CNN
F 1 "100n" H 10456 1515 40  0000 L CNN
F 2 "~" H 10488 1450 30  0000 C CNN
F 3 "~" H 10450 1600 60  0000 C CNN
	1    10450 1600
	0    -1   -1   0   
$EndComp
$Comp
L C C6
U 1 1 5416D70C
P 9050 4200
F 0 "C6" H 9050 4300 40  0000 L CNN
F 1 "100n" H 9056 4115 40  0000 L CNN
F 2 "~" H 9088 4050 30  0000 C CNN
F 3 "~" H 9050 4200 60  0000 C CNN
	1    9050 4200
	0    -1   -1   0   
$EndComp
$Comp
L DIODE D4
U 1 1 5416D7D5
P 9650 4050
F 0 "D4" H 9650 4150 40  0000 C CNN
F 1 "DIODE" H 9650 3950 40  0000 C CNN
F 2 "~" H 9650 4050 60  0000 C CNN
F 3 "~" H 9650 4050 60  0000 C CNN
	1    9650 4050
	1    0    0    -1  
$EndComp
$Comp
L DIODE D8
U 1 1 5416D7E2
P 9650 4350
F 0 "D8" H 9650 4450 40  0000 C CNN
F 1 "DIODE" H 9650 4250 40  0000 C CNN
F 2 "~" H 9650 4350 60  0000 C CNN
F 3 "~" H 9650 4350 60  0000 C CNN
	1    9650 4350
	-1   0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 5416DB1C
P 8700 1900
F 0 "C5" H 8700 2000 40  0000 L CNN
F 1 "100n" H 8706 1815 40  0000 L CNN
F 2 "~" H 8738 1750 30  0000 C CNN
F 3 "~" H 8700 1900 60  0000 C CNN
	1    8700 1900
	-1   0    0    1   
$EndComp
$Comp
L R R14
U 1 1 5416DB22
P 9100 1600
F 0 "R14" V 9180 1600 40  0000 C CNN
F 1 "1K" V 9107 1601 40  0000 C CNN
F 2 "~" V 9030 1600 30  0000 C CNN
F 3 "~" H 9100 1600 30  0000 C CNN
	1    9100 1600
	0    -1   -1   0   
$EndComp
$Comp
L R R13
U 1 1 5416DCB7
P 8250 2300
F 0 "R13" V 8350 2300 40  0000 C CNN
F 1 "100K" V 8257 2301 40  0000 C CNN
F 2 "~" V 8180 2300 30  0000 C CNN
F 3 "~" H 8250 2300 30  0000 C CNN
	1    8250 2300
	0    -1   -1   0   
$EndComp
$Comp
L DIODE D7
U 1 1 5416E03F
P 4950 5900
F 0 "D7" H 4950 6000 40  0000 C CNN
F 1 "DIODE" H 4950 5800 40  0000 C CNN
F 2 "~" H 4950 5900 60  0000 C CNN
F 3 "~" H 4950 5900 60  0000 C CNN
	1    4950 5900
	-1   0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 5416E04B
P 3400 6150
F 0 "C3" H 3400 6250 40  0000 L CNN
F 1 "1u" H 3406 6065 40  0000 L CNN
F 2 "~" H 3438 6000 30  0000 C CNN
F 3 "~" H 3400 6150 60  0000 C CNN
	1    3400 6150
	1    0    0    -1  
$EndComp
Text Notes 9950 1300 2    60   ~ 0
Wien Bridge Oscillator
Text Notes 8050 1050 2    60   ~ 0
Shrink Signal
Text Notes 10450 1000 2    98   ~ 0
Step 1: Create an AC Signal
Text Notes 6500 3500 2    60   ~ 0
Probe
Text HLabel 6400 3300 2    60   Input ~ 0
EC_ProbeIN
Text GLabel 4450 2150 0    59   Output ~ 0
EC_Signal
Wire Wire Line
	9900 4050 9850 4050
Wire Wire Line
	9900 4050 9900 4350
Wire Wire Line
	9900 4350 9850 4350
Wire Wire Line
	9450 4050 9400 4050
Wire Wire Line
	9400 4050 9400 4350
Wire Wire Line
	9400 4350 9450 4350
Wire Wire Line
	10600 3400 10750 3400
Wire Wire Line
	3400 6950 3400 6350
Wire Wire Line
	8500 2300 9050 2300
Wire Wire Line
	10000 2400 10000 4200
Wire Wire Line
	10000 2400 9750 2400
Wire Wire Line
	10100 3400 10000 3400
Connection ~ 10000 3400
Wire Wire Line
	10750 3400 10750 3750
Wire Wire Line
	5800 2050 6250 2050
Wire Wire Line
	4450 2150 5100 2150
Wire Wire Line
	5800 2250 6000 2250
Wire Notes Line
	6250 3300 6550 3300
Wire Notes Line
	6550 3950 6200 3950
Wire Notes Line
	6200 3950 6200 3300
Wire Notes Line
	6200 3300 6350 3300
Wire Notes Line
	6550 3300 6550 3950
Wire Notes Line
	6100 3850 6700 3450
Wire Notes Line
	6700 3450 6700 3550
Wire Notes Line
	6700 3450 6600 3450
Text Notes 6250 1000 2    98   ~ 0
Step 2:  Get EC Measurement
Wire Notes Line
	7050 800  11200 800 
Wire Notes Line
	11200 800  11150 4500
Wire Notes Line
	11150 4500 7050 4500
Wire Notes Line
	7050 4500 7050 800 
Wire Notes Line
	7000 800  7000 4500
Wire Notes Line
	7000 4500 3900 4500
Wire Notes Line
	3900 4500 3900 800 
Wire Notes Line
	3900 800  7000 800 
Wire Wire Line
	6350 3950 6350 4350
Wire Wire Line
	6350 4350 6500 4350
Text GLabel 6200 5800 2    59   Input ~ 0
EC_Signal
Wire Wire Line
	7650 2300 8000 2300
Wire Wire Line
	6000 5800 6200 5800
Text Notes 6850 4900 2    98   ~ 0
Step 3: Convert AC to DC
$Comp
L MCP6244 U1
U 2 1 5419C202
P 9500 2300
F 0 "U1" H 9600 2500 60  0000 L CNN
F 1 "MCP6244" H 9550 2100 60  0000 L CNN
F 2 "~" H 9600 2300 60  0000 C CNN
F 3 "~" H 9600 2300 60  0000 C CNN
	2    9500 2300
	-1   0    0    -1  
$EndComp
$Comp
L MCP6244 U1
U 3 1 5419C208
P 5550 2150
F 0 "U1" H 5650 2350 60  0000 L CNN
F 1 "MCP6244" H 5600 1950 60  0000 L CNN
F 2 "~" H 5650 2150 60  0000 C CNN
F 3 "~" H 5650 2150 60  0000 C CNN
	3    5550 2150
	-1   0    0    -1  
$EndComp
$Comp
L MCP6244 U1
U 4 1 5419C20E
P 5750 5900
F 0 "U1" H 5850 6100 60  0000 L CNN
F 1 "MCP6244" H 5800 5700 60  0000 L CNN
F 2 "~" H 5850 5900 60  0000 C CNN
F 3 "~" H 5850 5900 60  0000 C CNN
	4    5750 5900
	-1   0    0    -1  
$EndComp
Text GLabel 6250 2600 2    60   Input ~ 0
AC_Shrunk
Text GLabel 7650 2300 0    60   Output ~ 0
AC_Shrunk
Wire Wire Line
	6250 2050 6250 2600
Wire Wire Line
	8850 1600 8700 1600
Wire Wire Line
	8700 1600 8700 1700
Wire Wire Line
	8700 2100 8700 2300
Connection ~ 8700 2300
Wire Wire Line
	8750 2300 8750 4200
Connection ~ 8750 2300
Wire Wire Line
	10000 4200 9900 4200
Connection ~ 9900 4200
Wire Wire Line
	9400 4200 9250 4200
Connection ~ 9400 4200
Wire Wire Line
	8750 4200 8850 4200
Text Label 8750 3050 0    60   ~ 0
W_Vout
Text Label 10000 3150 0    60   ~ 0
W_Vin-
Text Label 9800 2200 0    60   ~ 0
W_Vin+
Text Label 8700 1600 0    60   ~ 0
f1
Text Label 9300 4200 0    60   ~ 0
G1
Wire Wire Line
	6000 2250 6000 3200
Wire Wire Line
	6000 3200 6400 3200
Wire Wire Line
	6400 3200 6400 3300
Wire Wire Line
	10650 1600 10800 1600
Wire Wire Line
	10800 1600 10800 2200
Wire Wire Line
	10800 2200 10750 2200
Wire Wire Line
	9350 1600 10250 1600
Wire Wire Line
	9750 2200 10250 2200
Wire Wire Line
	10050 1600 10050 2200
Connection ~ 10050 2200
Connection ~ 10050 1600
Wire Wire Line
	10800 2450 10950 2450
Wire Wire Line
	10950 2450 10950 1950
Wire Wire Line
	10950 1950 10800 1950
Connection ~ 10800 1950
Wire Wire Line
	7700 1150 8150 1150
Wire Wire Line
	4800 2150 4800 3100
Connection ~ 4800 2150
Wire Wire Line
	4800 3100 5100 3100
Wire Wire Line
	8750 3300 9100 3300
Connection ~ 8750 3300
Wire Wire Line
	9600 3300 10000 3300
Connection ~ 10000 3300
Wire Wire Line
	7700 1350 7700 1150
Wire Wire Line
	5600 3100 6000 3100
Connection ~ 6000 3100
$Comp
L R R4
U 1 1 5486055C
P 9350 3300
F 0 "R4" V 9430 3300 40  0000 C CNN
F 1 "22K" V 9357 3301 40  0000 C CNN
F 2 "~" V 9280 3300 30  0000 C CNN
F 3 "~" H 9350 3300 30  0000 C CNN
	1    9350 3300
	0    -1   -1   0   
$EndComp
$Comp
L R R3
U 1 1 54860697
P 7700 1600
F 0 "R3" V 7780 1600 40  0000 C CNN
F 1 "22K" V 7707 1601 40  0000 C CNN
F 2 "~" V 7630 1600 30  0000 C CNN
F 3 "~" H 7700 1600 30  0000 C CNN
	1    7700 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 1850 7700 2300
Connection ~ 7700 2300
$Comp
L R R2
U 1 1 54860754
P 5350 3100
F 0 "R2" V 5430 3100 40  0000 C CNN
F 1 "1K 1%" V 5357 3101 40  0000 C CNN
F 2 "~" V 5280 3100 30  0000 C CNN
F 3 "~" H 5350 3100 30  0000 C CNN
	1    5350 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5300 5900 5150 5900
$Comp
L DIODE D6
U 1 1 5486091F
P 4250 5900
F 0 "D6" H 4250 6000 40  0000 C CNN
F 1 "DIODE" H 4250 5800 40  0000 C CNN
F 2 "~" H 4250 5900 60  0000 C CNN
F 3 "~" H 4250 5900 60  0000 C CNN
	1    4250 5900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4450 5900 4750 5900
Wire Wire Line
	3050 5900 4050 5900
Wire Wire Line
	3750 5900 3750 6450
Wire Wire Line
	3750 6450 6100 6450
Wire Wire Line
	6100 6450 6100 6000
Wire Wire Line
	6100 6000 6000 6000
Wire Wire Line
	3400 5900 3400 5950
Connection ~ 3750 5900
Connection ~ 3400 5900
Wire Wire Line
	2350 6000 1350 6000
Wire Wire Line
	3050 6100 3150 6100
Wire Wire Line
	3150 6100 3150 6850
Wire Wire Line
	3150 6850 1650 6850
$Comp
L R R12
U 1 1 54860E67
P 3650 4800
F 0 "R12" V 3730 4800 40  0000 C CNN
F 1 "1K" V 3657 4801 40  0000 C CNN
F 2 "~" V 3580 4800 30  0000 C CNN
F 3 "~" H 3650 4800 30  0000 C CNN
	1    3650 4800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1800 4800 3400 4800
Wire Wire Line
	3900 4800 4600 4800
Wire Wire Line
	4600 4800 4600 5900
Connection ~ 4600 5900
$Comp
L C C8
U 1 1 548611AE
P 2550 5450
F 0 "C8" H 2550 5550 40  0000 L CNN
F 1 ".1u" H 2556 5365 40  0000 L CNN
F 2 "~" H 2588 5300 30  0000 C CNN
F 3 "~" H 2550 5450 60  0000 C CNN
	1    2550 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 5100 2800 5700
Wire Wire Line
	2550 5250 2800 5250
Connection ~ 2800 5250
Wire Notes Line
	800  4600 7200 4600
Wire Notes Line
	7200 4600 7200 7100
Wire Notes Line
	7200 7100 800  7100
Wire Notes Line
	800  7100 800  4600
Text HLabel 1350 6000 0    60   Output ~ 0
EC_AIN
Text Label 5550 6450 0    60   ~ 0
RVin-
Text Label 5200 5900 0    60   ~ 0
R_Vout
Text Label 4600 5500 0    60   ~ 0
DD
Wire Wire Line
	1800 4800 1800 6000
Connection ~ 1800 6000
Wire Wire Line
	1650 6850 1650 6000
Connection ~ 1650 6000
Wire Wire Line
	2550 5650 2550 5750
Wire Wire Line
	2800 6300 2800 6450
Text GLabel 2800 5100 2    60   Input ~ 0
Vclean
Text GLabel 2800 6450 0    60   Input ~ 0
GND
Text GLabel 3400 6950 2    60   Input ~ 0
VGND
Text GLabel 6500 4350 2    60   Input ~ 0
VGND
Text GLabel 8150 1150 2    60   Input ~ 0
VGND
Text GLabel 10750 3750 0    60   Input ~ 0
VGND
Text GLabel 10800 2450 0    60   Input ~ 0
VGND
$Comp
L MCP6244 U1
U 1 1 549068E6
P 2800 6000
F 0 "U1" H 2900 6200 60  0000 L CNN
F 1 "MCP6244" H 2850 5800 60  0000 L CNN
F 2 "~" H 2900 6000 60  0000 C CNN
F 3 "~" H 2900 6000 60  0000 C CNN
	1    2800 6000
	-1   0    0    -1  
$EndComp
Text GLabel 2550 5750 0    60   Input ~ 0
GND
$EndSCHEMATC
