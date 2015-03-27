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
Sheet 1 10
Title ""
Date "26 mar 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 800  2100 2500 4250
U 547DE474
F0 "Arduino" 50
F1 "Arduino.sch" 50
F2 "SDA" B R 3300 2400 60 
F3 "SCL" O R 3300 2200 60 
F4 "pump2_pin" O R 3300 5650 60 
F5 "pump1_pin" O R 3300 5450 60 
F6 "pump3_pin" O R 3300 5850 60 
F7 "MUX_out_pin" O R 3300 3950 60 
F8 "FET_pin" O R 3300 4150 60 
F9 "12V" O R 3300 5250 60 
$EndSheet
$Sheet
S 4050 1650 1900 2100
U 547DE4F5
F0 "DigitalAccess" 50
F1 "DigitalAccess.sch" 50
F2 "SCL" I L 4050 2200 60 
F3 "SDA" B L 4050 2400 60 
F4 "pH_AIN" I R 5950 2050 60 
F5 "EC_AIN" I R 5950 3550 60 
$EndSheet
$Sheet
S 6750 850  2550 1250
U 547DE57A
F0 "pH" 50
F1 "pH.sch" 50
F2 "pH_AIN" O L 6750 1250 60 
F3 "pH_ProbeIN" I R 9300 1250 60 
$EndSheet
$Sheet
S 6950 3300 2600 1000
U 547DE5B0
F0 "EC" 50
F1 "EC.sch" 50
F2 "EC_ProbeIN" I R 9550 3650 60 
F3 "EC_AIN" O L 6950 3550 60 
F4 "MUX_out_pin" I L 6950 3950 60 
F5 "FET_pin" I L 6950 4150 60 
$EndSheet
$Sheet
S 1350 700  2350 1300
U 547DE6F9
F0 "Power" 50
F1 "Power.sch" 50
$EndSheet
Wire Wire Line
	9300 1250 10550 1250
Wire Wire Line
	6750 1250 6600 1250
Wire Wire Line
	6600 1250 6600 2050
Wire Wire Line
	6600 2050 5950 2050
Wire Wire Line
	3300 2200 4050 2200
Wire Wire Line
	3300 2400 4050 2400
Connection ~ 6350 6850
Text GLabel 10700 1700 0    60   Input ~ 0
VGND
Text GLabel 10900 4000 0    60   Input ~ 0
VGND
$Comp
L BNC P3
U 1 1 54903E24
P 10700 1250
F 0 "P3" H 10710 1370 60  0000 C CNN
F 1 "BNC" V 10810 1190 40  0000 C CNN
F 2 "~" H 10700 1250 60  0000 C CNN
F 3 "~" H 10700 1250 60  0000 C CNN
	1    10700 1250
	1    0    0    -1  
$EndComp
$Comp
L BNC P4
U 1 1 54903E31
P 10900 3650
F 0 "P4" H 10910 3770 60  0000 C CNN
F 1 "BNC" V 11010 3590 40  0000 C CNN
F 2 "~" H 10900 3650 60  0000 C CNN
F 3 "~" H 10900 3650 60  0000 C CNN
	1    10900 3650
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 54903E48
P 7750 5850
F 0 "P1" V 7700 5850 60  0000 C CNN
F 1 "CONN_6" V 7800 5850 60  0000 C CNN
F 2 "" H 7750 5850 60  0000 C CNN
F 3 "" H 7750 5850 60  0000 C CNN
	1    7750 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 1450 10700 1700
Wire Wire Line
	10750 3650 9550 3650
Wire Wire Line
	10900 3850 10900 4000
Wire Wire Line
	3300 5450 4400 5450
Wire Wire Line
	3300 5650 4400 5650
Wire Wire Line
	3300 5850 4400 5850
Wire Wire Line
	6050 5700 7400 5700
Wire Wire Line
	6650 5800 7400 5800
Wire Wire Line
	6050 5900 7400 5900
Wire Wire Line
	6650 6000 7400 6000
Wire Wire Line
	6050 6100 7400 6100
Wire Wire Line
	3300 3950 6950 3950
Wire Wire Line
	3300 5250 4400 5250
$Sheet
S 4400 5100 1650 1300
U 547DE6BF
F0 "Pumps" 50
F1 "Pumps.sch" 50
F2 "pump2_pin" I L 4400 5650 60 
F3 "pump3_pin" I L 4400 5850 60 
F4 "pump1_pin" I L 4400 5450 60 
F5 "12V" I L 4400 5250 60 
F6 "pump1" O R 6050 5700 60 
F7 "pump2" O R 6050 5900 60 
F8 "pump3" O R 6050 6100 60 
$EndSheet
Wire Wire Line
	6650 4850 6650 6000
Wire Wire Line
	7400 5600 6650 5600
Connection ~ 6650 5600
Connection ~ 6650 5800
Wire Wire Line
	3850 5250 3850 4850
Wire Wire Line
	3850 4850 6650 4850
Connection ~ 3850 5250
$Comp
L CONN_1 TP2
U 1 1 5513E844
P 6450 2400
F 0 "TP2" H 6530 2400 40  0001 L CNN
F 1 "pH_AIN" H 6450 2455 30  0000 C CNN
F 2 "" H 6450 2400 60  0000 C CNN
F 3 "" H 6450 2400 60  0000 C CNN
	1    6450 2400
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 TP3
U 1 1 5513E851
P 6550 3100
F 0 "TP3" H 6630 3100 40  0001 L CNN
F 1 "EC_AIN" H 6550 3155 30  0000 C CNN
F 2 "" H 6550 3100 60  0000 C CNN
F 3 "" H 6550 3100 60  0000 C CNN
	1    6550 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2400 6300 2050
Connection ~ 6300 2050
Wire Wire Line
	5950 3550 6950 3550
Wire Wire Line
	3300 4150 6950 4150
Wire Wire Line
	6400 3100 6400 3550
Connection ~ 6400 3550
$EndSCHEMATC
