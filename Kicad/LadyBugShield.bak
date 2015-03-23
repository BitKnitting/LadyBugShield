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
Sheet 1 9
Title ""
Date "17 mar 2015"
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
F4 "MUX_out_pin" O R 3300 4250 60 
F5 "FET_pin" O R 3300 4450 60 
F6 "12V" O R 3300 5100 60 
F7 "Pump1_SW" O R 3300 5300 60 
F8 "Pump2_SW" O R 3300 5500 60 
F9 "Pump3_SW" O R 3300 5700 60 
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
S 6750 3600 2600 1000
U 547DE5B0
F0 "EC" 50
F1 "EC.sch" 50
F2 "EC_ProbeIN" I R 9350 3950 60 
F3 "EC_AIN" O L 6750 3850 60 
F4 "MUX_out_pin" I L 6750 4250 60 
F5 "FET_pin" I L 6750 4450 60 
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
Text GLabel 10700 4300 0    60   Input ~ 0
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
P 10700 3950
F 0 "P4" H 10710 4070 60  0000 C CNN
F 1 "BNC" V 10810 3890 40  0000 C CNN
F 2 "~" H 10700 3950 60  0000 C CNN
F 3 "~" H 10700 3950 60  0000 C CNN
	1    10700 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 1450 10700 1700
Wire Wire Line
	10550 3950 9350 3950
Wire Wire Line
	10700 4150 10700 4300
Wire Wire Line
	6750 3850 6300 3850
Wire Wire Line
	6300 3850 6300 3550
Wire Wire Line
	6300 3550 5950 3550
Wire Wire Line
	3300 4250 6750 4250
Wire Wire Line
	3300 4450 6750 4450
$Comp
L CONN_6 P1
U 1 1 550579A6
P 4750 5250
F 0 "P1" V 4700 5250 60  0000 C CNN
F 1 "CONN_6" V 4800 5250 60  0000 C CNN
F 2 "" H 4750 5250 60  0000 C CNN
F 3 "" H 4750 5250 60  0000 C CNN
	1    4750 5250
	1    0    0    -1  
$EndComp
$Comp
L CONN_1 pHAIN_TP1
U 1 1 5506C613
P 6300 1650
F 0 "pHAIN_TP1" H 6380 1650 40  0000 L CNN
F 1 "CONN_1" H 6300 1705 30  0001 C CNN
F 2 "" H 6300 1650 60  0000 C CNN
F 3 "" H 6300 1650 60  0000 C CNN
	1    6300 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 1650 6150 2050
Connection ~ 6150 2050
$Comp
L CONN_1 ECAIN_TP1
U 1 1 5506C6CE
P 6350 3250
F 0 "ECAIN_TP1" H 6430 3250 40  0000 L CNN
F 1 "CONN_1" H 6350 3305 30  0001 C CNN
F 2 "" H 6350 3250 60  0000 C CNN
F 3 "" H 6350 3250 60  0000 C CNN
	1    6350 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 3250 6200 3550
Connection ~ 6200 3550
Wire Wire Line
	4400 5000 3500 5000
Wire Wire Line
	3500 5000 3500 5400
Wire Wire Line
	3500 5100 3300 5100
Wire Wire Line
	3500 5200 4400 5200
Connection ~ 3500 5100
Wire Wire Line
	3500 5400 4400 5400
Connection ~ 3500 5200
Wire Wire Line
	3300 5300 3950 5300
Wire Wire Line
	3950 5300 3950 5100
Wire Wire Line
	3950 5100 4400 5100
Wire Wire Line
	3300 5500 4150 5500
Wire Wire Line
	4150 5500 4150 5300
Wire Wire Line
	4150 5300 4400 5300
Wire Wire Line
	3300 5700 4300 5700
Wire Wire Line
	4300 5700 4300 5500
Wire Wire Line
	4300 5500 4400 5500
$EndSCHEMATC
