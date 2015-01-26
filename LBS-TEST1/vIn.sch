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
Sheet 2 5
Title ""
Date "26 jan 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R3
U 1 1 54B65D25
P 6800 3100
F 0 "R3" V 6880 3100 40  0000 C CNN
F 1 "1K" V 6807 3101 40  0000 C CNN
F 2 "~" V 6730 3100 30  0000 C CNN
F 3 "~" H 6800 3100 30  0000 C CNN
	1    6800 3100
	0    1    -1   0   
$EndComp
$Comp
L R R4
U 1 1 54B65D2B
P 6950 4300
F 0 "R4" V 7030 4300 40  0000 C CNN
F 1 "10K" V 6957 4301 40  0000 C CNN
F 2 "~" V 6880 4300 30  0000 C CNN
F 3 "~" H 6950 4300 30  0000 C CNN
	1    6950 4300
	0    1    -1   0   
$EndComp
$Comp
L C C3
U 1 1 54B65D31
P 6800 2200
F 0 "C3" H 6800 2300 40  0000 L CNN
F 1 "100n" H 6806 2115 40  0000 L CNN
F 2 "~" H 6838 2050 30  0000 C CNN
F 3 "~" H 6800 2200 60  0000 C CNN
	1    6800 2200
	0    1    -1   0   
$EndComp
$Comp
L C C4
U 1 1 54B65D37
P 8250 5100
F 0 "C4" H 8250 5200 40  0000 L CNN
F 1 "100n" H 8256 5015 40  0000 L CNN
F 2 "~" H 8288 4950 30  0000 C CNN
F 3 "~" H 8250 5100 60  0000 C CNN
	1    8250 5100
	0    1    -1   0   
$EndComp
$Comp
L DIODE D1
U 1 1 54B65D3D
P 7650 4950
F 0 "D1" H 7650 5050 40  0000 C CNN
F 1 "DIODE" H 7650 4850 40  0000 C CNN
F 2 "~" H 7650 4950 60  0000 C CNN
F 3 "~" H 7650 4950 60  0000 C CNN
	1    7650 4950
	-1   0    0    -1  
$EndComp
$Comp
L DIODE D2
U 1 1 54B65D43
P 7650 5250
F 0 "D2" H 7650 5350 40  0000 C CNN
F 1 "DIODE" H 7650 5150 40  0000 C CNN
F 2 "~" H 7650 5250 60  0000 C CNN
F 3 "~" H 7650 5250 60  0000 C CNN
	1    7650 5250
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 54B65D49
P 8600 2800
F 0 "C5" H 8600 2900 40  0000 L CNN
F 1 "100n" H 8606 2715 40  0000 L CNN
F 2 "~" H 8638 2650 30  0000 C CNN
F 3 "~" H 8600 2800 60  0000 C CNN
	1    8600 2800
	1    0    0    1   
$EndComp
$Comp
L R R6
U 1 1 54B65D4F
P 8250 2200
F 0 "R6" V 8330 2200 40  0000 C CNN
F 1 "1K" V 8257 2201 40  0000 C CNN
F 2 "~" V 8180 2200 30  0000 C CNN
F 3 "~" H 8250 2200 30  0000 C CNN
	1    8250 2200
	0    1    -1   0   
$EndComp
$Comp
L R R7
U 1 1 54B65D55
P 9050 3200
F 0 "R7" V 9150 3200 40  0000 C CNN
F 1 "100K" V 9057 3201 40  0000 C CNN
F 2 "~" V 8980 3200 30  0000 C CNN
F 3 "~" H 9050 3200 30  0000 C CNN
	1    9050 3200
	0    1    -1   0   
$EndComp
Text Notes 7450 2000 0    60   ~ 0
Wien Bridge Oscillator
Text Notes 9250 1950 0    60   ~ 0
Shrink Signal
Text Notes 9100 1550 2    98   ~ 0
 Create an AC Signal
Text Label 7300 4050 2    60   ~ 0
OSC_Vin-
Text Label 7500 3100 2    60   ~ 0
OSC_Vin+
Text Label 8600 2200 2    60   ~ 0
f1
Text Label 8000 5100 2    60   ~ 0
G1
$Comp
L R R5
U 1 1 54B65D9C
P 7950 4200
F 0 "R5" V 8030 4200 40  0000 C CNN
F 1 "22K" V 7957 4201 40  0000 C CNN
F 2 "~" V 7880 4200 30  0000 C CNN
F 3 "~" H 7950 4200 30  0000 C CNN
	1    7950 4200
	0    1    -1   0   
$EndComp
$Comp
L R R8
U 1 1 54B65DA2
P 9600 2500
F 0 "R8" V 9680 2500 40  0000 C CNN
F 1 "22K" V 9607 2501 40  0000 C CNN
F 2 "~" V 9530 2500 30  0000 C CNN
F 3 "~" H 9600 2500 30  0000 C CNN
	1    9600 2500
	-1   0    0    -1  
$EndComp
$Comp
L MCP6244 U2
U 1 1 54B65DB4
P 7800 3200
F 0 "U2" H 7900 3400 60  0000 L CNN
F 1 "MCP6244" H 7850 3000 60  0000 L CNN
F 2 "~" H 7900 3200 60  0000 C CNN
F 3 "~" H 7900 3200 60  0000 C CNN
	1    7800 3200
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 54B66EE0
P 1950 2950
F 0 "R1" V 2030 2950 40  0000 C CNN
F 1 "1K" V 1957 2951 40  0000 C CNN
F 2 "~" V 1880 2950 30  0000 C CNN
F 3 "~" H 1950 2950 30  0000 C CNN
	1    1950 2950
	-1   0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 54B66EE6
P 1950 3800
F 0 "R2" V 2030 3800 40  0000 C CNN
F 1 "1K" V 1957 3801 40  0000 C CNN
F 2 "~" V 1880 3800 30  0000 C CNN
F 3 "~" H 1950 3800 30  0000 C CNN
	1    1950 3800
	-1   0    0    -1  
$EndComp
Text Notes 3200 2300 2    98   ~ 0
Raise GND
$Comp
L C C1
U 1 1 54B66F03
P 2200 2800
F 0 "C1" H 2200 2900 40  0000 L CNN
F 1 ".1u" H 2206 2715 40  0000 L CNN
F 2 "~" H 2238 2650 30  0000 C CNN
F 3 "~" H 2200 2800 60  0000 C CNN
	1    2200 2800
	-1   0    0    -1  
$EndComp
Text Label 2300 3400 2    60   ~ 0
VGND_V+
$Comp
L C C2
U 1 1 54B66F1A
P 3200 2900
F 0 "C2" H 3200 3000 40  0000 L CNN
F 1 ".1u" H 3206 2815 40  0000 L CNN
F 2 "~" H 3238 2750 30  0000 C CNN
F 3 "~" H 3200 2900 60  0000 C CNN
	1    3200 2900
	-1   0    0    -1  
$EndComp
Text HLabel 950  2500 0    60   Input ~ 0
+5V
Text HLabel 900  4250 0    60   Input ~ 0
GND
Text HLabel 3100 4000 2    60   Input ~ 0
GND
Text HLabel 2350 3100 2    60   Input ~ 0
GND
Text HLabel 3450 3200 2    60   Input ~ 0
GND
Text HLabel 4900 3500 2    60   Output ~ 0
VGND
Text HLabel 6500 3350 2    60   Input ~ 0
VGND
Text HLabel 6550 4650 2    60   Input ~ 0
VGND
Text HLabel 9150 2050 0    60   Input ~ 0
VGND
Text HLabel 10600 3200 2    60   Output ~ 0
AC_SHRUNK
Text GLabel 4250 2500 2    60   Output ~ 0
5+V
Text GLabel 4050 4250 2    60   Output ~ 0
PGND
$Comp
L C C8
U 1 1 54B6DA3F
P 7600 2450
F 0 "C8" H 7600 2550 40  0000 L CNN
F 1 ".1u" H 7606 2365 40  0000 L CNN
F 2 "~" H 7638 2300 30  0000 C CNN
F 3 "~" H 7600 2450 60  0000 C CNN
	1    7600 2450
	-1   0    0    -1  
$EndComp
Text GLabel 7350 2450 3    60   Input ~ 0
5+V
Text GLabel 7600 2700 3    60   Output ~ 0
PGND
Text GLabel 7900 3650 2    60   Output ~ 0
PGND
Wire Wire Line
	7400 4950 7450 4950
Wire Wire Line
	7400 4950 7400 5250
Wire Wire Line
	7400 5250 7450 5250
Wire Wire Line
	7850 4950 7900 4950
Wire Wire Line
	7900 4950 7900 5250
Wire Wire Line
	7900 5250 7850 5250
Wire Wire Line
	6700 4300 6550 4300
Wire Wire Line
	8250 3200 8800 3200
Wire Wire Line
	7300 3300 7300 5100
Wire Wire Line
	7300 3300 7550 3300
Wire Wire Line
	7200 4300 7300 4300
Connection ~ 7300 4300
Wire Wire Line
	6550 4300 6550 4650
Wire Wire Line
	9300 3200 10600 3200
Wire Wire Line
	8600 3000 8600 3200
Connection ~ 8600 3200
Wire Wire Line
	8550 3200 8550 5100
Connection ~ 8550 3200
Wire Wire Line
	7300 5100 7400 5100
Connection ~ 7400 5100
Wire Wire Line
	7900 5100 8050 5100
Connection ~ 7900 5100
Wire Wire Line
	8550 5100 8450 5100
Wire Wire Line
	6500 3100 6550 3100
Wire Wire Line
	7050 3100 7550 3100
Connection ~ 7250 3100
Wire Wire Line
	6500 3350 6350 3350
Wire Wire Line
	6350 3350 6350 2850
Wire Wire Line
	6350 2850 6500 2850
Wire Wire Line
	9600 2050 9150 2050
Wire Wire Line
	8550 4200 8200 4200
Connection ~ 8550 4200
Wire Wire Line
	7700 4200 7300 4200
Connection ~ 7300 4200
Wire Wire Line
	9600 2250 9600 2050
Wire Wire Line
	9600 2750 9600 3200
Connection ~ 9600 3200
Wire Wire Line
	1950 2500 1950 2700
Wire Wire Line
	1950 3200 1950 3550
Wire Wire Line
	2650 3400 1950 3400
Connection ~ 1950 3400
Wire Wire Line
	2650 3600 2350 3600
Wire Wire Line
	2350 3600 2350 4200
Wire Wire Line
	2350 4200 3650 4200
Wire Wire Line
	3650 4200 3650 3500
Wire Wire Line
	3350 3500 4900 3500
Connection ~ 3650 3500
Wire Notes Line
	1200 2150 4600 2150
Wire Notes Line
	4600 2150 4600 4450
Wire Notes Line
	4600 4450 1200 4450
Wire Notes Line
	1200 4450 1200 2150
Wire Wire Line
	950  2500 4250 2500
Wire Wire Line
	2900 3800 2900 4000
Wire Wire Line
	3200 3100 3200 3200
Wire Wire Line
	2200 2600 1950 2600
Connection ~ 1950 2600
Wire Wire Line
	2200 3000 2200 3100
Wire Wire Line
	900  4250 4050 4250
Wire Wire Line
	1950 4250 1950 4050
Wire Wire Line
	3200 2500 3200 2700
Connection ~ 1950 2500
Wire Wire Line
	2900 4000 3100 4000
Wire Wire Line
	2200 3100 2350 3100
Wire Wire Line
	3200 3200 3450 3200
Wire Notes Line
	6100 1850 10450 1850
Wire Notes Line
	10450 1850 10450 5450
Wire Notes Line
	10450 5450 6050 5450
Wire Notes Line
	6050 5450 6100 1850
Connection ~ 3200 2500
Connection ~ 1950 4250
Wire Wire Line
	2900 2650 3200 2650
Connection ~ 3200 2650
Wire Wire Line
	7800 2250 7800 2900
Wire Wire Line
	8350 2750 8350 2800
Wire Wire Line
	7800 3500 7800 3650
Wire Wire Line
	7800 3650 7900 3650
Wire Wire Line
	7350 2250 7350 2450
Wire Wire Line
	7350 2250 7800 2250
Connection ~ 7600 2250
Wire Wire Line
	7250 2200 7250 3100
Wire Wire Line
	7000 2200 8000 2200
Connection ~ 7250 2200
Wire Wire Line
	7600 2650 7600 2700
Text Label 8350 3200 0    60   ~ 0
OSC_Vout
Wire Wire Line
	6500 2200 6500 3100
Wire Wire Line
	6500 2200 6600 2200
Connection ~ 6500 2850
Wire Wire Line
	8600 2600 8600 2200
Wire Wire Line
	8600 2200 8500 2200
Wire Wire Line
	2900 2650 2900 3200
$Comp
L MCP6241 U1
U 1 1 54B7A6F0
P 3000 3500
F 0 "U1" H 3000 3650 60  0000 L CNN
F 1 "MCP6241" H 3000 3350 60  0000 L CNN
F 2 "~" H 3000 3500 60  0000 C CNN
F 3 "~" H 3000 3500 60  0000 C CNN
	1    3000 3500
	1    0    0    -1  
$EndComp
$EndSCHEMATC
