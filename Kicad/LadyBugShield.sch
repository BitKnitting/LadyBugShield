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
Sheet 1 8
Title ""
Date "20 dec 2014"
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
F4 "Pump2" O R 3300 5650 60 
F5 "Pump1" O R 3300 5450 60 
F6 "Pump3" O R 3300 5850 60 
$EndSheet
$Sheet
S 4050 1650 1900 2100
U 547DE4F5
F0 "DigitalAccess" 50
F1 "DigitalAccess.sch" 50
F2 "SCL" I L 4050 2200 60 
F3 "SDA" B L 4050 2400 60 
F4 "pH_AIN" I R 5950 2050 60 
F5 "EC_AIN" I R 5950 2650 60 
F6 "Therm_AIN" I R 5950 3050 60 
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
S 6750 2400 2600 1000
U 547DE5B0
F0 "EC" 50
F1 "EC.sch" 50
F2 "EC_ProbeIN" I R 9350 2750 60 
F3 "EC_AIN" O L 6750 2650 60 
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
	9400 4200 10200 4200
Wire Wire Line
	6750 1250 6600 1250
Wire Wire Line
	6600 1250 6600 2050
Wire Wire Line
	6600 2050 5950 2050
Wire Wire Line
	5950 2650 6750 2650
Wire Wire Line
	3300 2200 4050 2200
Wire Wire Line
	3300 2400 4050 2400
Connection ~ 6350 6850
$Sheet
S 6750 3900 2650 950 
U 547DE6A0
F0 "Temperature" 50
F1 "Temperature.sch" 50
F2 "Therm_IN" I R 9400 4200 60 
F3 "Therm_AIN" O L 6750 4200 60 
$EndSheet
Wire Wire Line
	5950 3050 6350 3050
Wire Wire Line
	6350 3050 6350 4200
Wire Wire Line
	6350 4200 6750 4200
Text GLabel 10700 1700 0    60   Input ~ 0
VGND
Text GLabel 10700 3100 0    60   Input ~ 0
VGND
Text GLabel 9950 4400 0    60   Input ~ 0
Vclean
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
P 10700 2750
F 0 "P4" H 10710 2870 60  0000 C CNN
F 1 "BNC" V 10810 2690 40  0000 C CNN
F 2 "~" H 10700 2750 60  0000 C CNN
F 3 "~" H 10700 2750 60  0000 C CNN
	1    10700 2750
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P2
U 1 1 54903E39
P 10550 4300
F 0 "P2" V 10500 4300 40  0000 C CNN
F 1 "CONN_2" V 10600 4300 40  0000 C CNN
F 2 "" H 10550 4300 60  0000 C CNN
F 3 "" H 10550 4300 60  0000 C CNN
	1    10550 4300
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 54903E48
P 6900 5550
F 0 "P1" V 6850 5550 60  0000 C CNN
F 1 "CONN_6" V 6950 5550 60  0000 C CNN
F 2 "" H 6900 5550 60  0000 C CNN
F 3 "" H 6900 5550 60  0000 C CNN
	1    6900 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 1450 10700 1700
Wire Wire Line
	10550 2750 9350 2750
Wire Wire Line
	10700 2950 10700 3100
Wire Wire Line
	3300 5450 4400 5450
Wire Wire Line
	3300 5650 4400 5650
Wire Wire Line
	3300 5850 4400 5850
$Sheet
S 4400 5100 1650 1300
U 547DE6BF
F0 "Pumps" 50
F1 "Pumps.sch" 50
F2 "Pump1" I L 4400 5450 60 
F3 "V+_Pump1" I R 6050 5300 60 
F4 "SW_Pump1" I R 6050 5400 60 
F5 "Pump2" I L 4400 5650 60 
F6 "SW_Pump2" I R 6050 5600 60 
F7 "V+_Pump2" I R 6050 5500 60 
F8 "Pump3" I L 4400 5850 60 
F9 "SW_Pump3" I R 6050 5700 60 
F10 "V+_Pump3" I R 6050 5800 60 
$EndSheet
Wire Wire Line
	9950 4400 10200 4400
Wire Wire Line
	6550 5300 6050 5300
Wire Wire Line
	6050 5400 6550 5400
Wire Wire Line
	6050 5500 6550 5500
Wire Wire Line
	6050 5600 6550 5600
Wire Wire Line
	6050 5700 6550 5700
Wire Wire Line
	6050 5800 6550 5800
$Comp
L CONN_1 TP1
U 1 1 54956214
P 10000 1000
F 0 "TP1" H 10080 1000 40  0000 L CNN
F 1 "CONN_1" H 10000 1055 30  0001 C CNN
F 2 "" H 10000 1000 60  0000 C CNN
F 3 "" H 10000 1000 60  0000 C CNN
	1    10000 1000
	0    -1   -1   0   
$EndComp
$Comp
L CONN_1 TP4
U 1 1 54956279
P 10900 1550
F 0 "TP4" H 10980 1550 40  0000 L CNN
F 1 "CONN_1" H 10900 1605 30  0001 C CNN
F 2 "" H 10900 1550 60  0000 C CNN
F 3 "" H 10900 1550 60  0000 C CNN
	1    10900 1550
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 TP2
U 1 1 5495627F
P 10050 2450
F 0 "TP2" H 10130 2450 40  0000 L CNN
F 1 "CONN_1" H 10050 2505 30  0001 C CNN
F 2 "" H 10050 2450 60  0000 C CNN
F 3 "" H 10050 2450 60  0000 C CNN
	1    10050 2450
	0    -1   -1   0   
$EndComp
$Comp
L CONN_1 TP3
U 1 1 54956285
P 10950 3000
F 0 "TP3" H 11030 3000 40  0000 L CNN
F 1 "CONN_1" H 10950 3055 30  0001 C CNN
F 2 "" H 10950 3000 60  0000 C CNN
F 3 "" H 10950 3000 60  0000 C CNN
	1    10950 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10000 1150 10000 1250
Connection ~ 10000 1250
Wire Wire Line
	10750 1550 10700 1550
Connection ~ 10700 1550
Wire Wire Line
	10050 2600 10050 2750
Connection ~ 10050 2750
Wire Wire Line
	10800 3000 10700 3000
Connection ~ 10700 3000
$EndSCHEMATC
