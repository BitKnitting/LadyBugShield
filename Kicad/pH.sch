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
Sheet 4 11
Title ""
Date "4 feb 2015"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1750 3200 0    60   Output ~ 0
pH_AIN
Wire Wire Line
	4150 3100 5900 3100
Wire Wire Line
	2950 4100 4750 4100
Wire Wire Line
	4750 4100 4750 3300
Wire Wire Line
	4750 3300 4150 3300
Wire Wire Line
	1750 3200 3450 3200
Wire Wire Line
	2950 4100 2950 3200
Connection ~ 2950 3200
Text HLabel 5900 3100 2    60   Input ~ 0
pH_ProbeIN
Text Notes 6050 3300 2    60   ~ 0
Probe
Wire Notes Line
	5800 3100 6100 3100
Wire Notes Line
	6100 3750 5750 3750
Wire Notes Line
	5750 3750 5750 3100
Wire Notes Line
	5750 3100 5900 3100
Wire Notes Line
	6100 3100 6100 3750
Wire Notes Line
	5650 3650 6250 3250
Wire Notes Line
	6250 3250 6250 3350
Wire Notes Line
	6250 3250 6150 3250
Wire Wire Line
	5900 3750 5900 4150
Wire Wire Line
	5900 4150 6050 4150
Text GLabel 6050 4150 2    60   Input ~ 0
VGND
$Comp
L MCP6241 U1
U 1 1 54CCCA62
P 3800 3200
F 0 "U1" H 3800 3350 60  0000 L CNN
F 1 "MCP6241" H 3800 3050 60  0000 L CNN
F 2 "~" H 3800 3200 60  0000 C CNN
F 3 "~" H 3800 3200 60  0000 C CNN
	1    3800 3200
	-1   0    0    1   
$EndComp
Wire Wire Line
	3900 3500 3900 3700
Wire Wire Line
	3900 3700 3800 3700
Text GLabel 1750 2550 0    60   Input ~ 0
Vclean
Wire Wire Line
	1750 2550 3900 2550
Wire Wire Line
	3900 2550 3900 2900
Text GLabel 3800 3700 0    60   Input ~ 0
GND
$EndSCHEMATC
