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
Sheet 7 9
Title ""
Date "17 mar 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 4950 4450 0    60   ~ 0
Probe
Text HLabel 5050 4250 0    60   Input ~ 0
EC_ProbeIN
Wire Wire Line
	6350 3100 7850 3100
Wire Wire Line
	5650 3200 5450 3200
Wire Notes Line
	5200 4250 4900 4250
Wire Notes Line
	4900 4900 5250 4900
Wire Notes Line
	5250 4900 5250 4250
Wire Notes Line
	5250 4250 5100 4250
Wire Notes Line
	4900 4250 4900 4900
Wire Notes Line
	5350 4800 4750 4400
Wire Notes Line
	4750 4400 4750 4500
Wire Notes Line
	4750 4400 4850 4400
Wire Wire Line
	5100 4900 5100 5300
Wire Wire Line
	5100 5300 4950 5300
$Comp
L MCP6244 U5
U 1 1 54C7A596
P 5900 3100
F 0 "U5" H 6000 3300 60  0000 L CNN
F 1 "MCP6244" H 5950 2900 60  0000 L CNN
F 2 "~" H 6000 3100 60  0000 C CNN
F 3 "~" H 6000 3100 60  0000 C CNN
	1    5900 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5450 3200 5450 4150
Wire Wire Line
	5450 4150 5050 4150
Wire Wire Line
	5050 4150 5050 4250
Wire Wire Line
	6650 3100 6650 4050
Connection ~ 6650 3100
Wire Wire Line
	6650 4050 6350 4050
Wire Wire Line
	5850 4050 5450 4050
Connection ~ 5450 4050
$Comp
L R R17
U 1 1 54C7A5A6
P 6100 4050
F 0 "R17" V 6180 4050 40  0000 C CNN
F 1 "1K .5%" V 6107 4051 40  0000 C CNN
F 2 "~" V 6030 4050 30  0000 C CNN
F 3 "~" H 6100 4050 30  0000 C CNN
	1    6100 4050
	0    1    -1   0   
$EndComp
$Comp
L C C6
U 1 1 54C7A5AC
P 6150 2550
F 0 "C6" H 6150 2650 40  0000 L CNN
F 1 ".1u" H 6156 2465 40  0000 L CNN
F 2 "~" H 6188 2400 30  0000 C CNN
F 3 "~" H 6150 2550 60  0000 C CNN
	1    6150 2550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5900 2200 5900 2800
Wire Wire Line
	6150 2350 5900 2350
Connection ~ 5900 2350
Wire Wire Line
	6150 2750 6150 2850
Wire Wire Line
	5900 3400 5900 3550
Text GLabel 5900 2200 0    60   Input ~ 0
Vclean
Text GLabel 5900 3550 2    60   Input ~ 0
GND
Text GLabel 4950 5300 0    60   Input ~ 0
VGND
Text GLabel 6150 2850 2    60   Input ~ 0
GND
Text HLabel 3450 3000 0    60   Input ~ 0
EC_VIN
Wire Wire Line
	3450 3000 5650 3000
Text HLabel 7850 3100 2    60   Output ~ 0
EC_VOUT
$EndSCHEMATC
