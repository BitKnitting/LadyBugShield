//
// HappyDay_Ladybug_EC.cpp
// Class library C++ code
//
// Project 		
//
// Created by 	Margaret Johnson, 3/30/15 12:56 PM
// 				__MyCompanyName__
//
// Copyright 	(c) Margaret Johnson, 2015
// Licence		<#license#>
//
//


// Library header
#include <avr/eeprom.h>
#include "HappyDay_Ladybug_EC.h"
#define LSB_mV  1
#define  FET_pin  A1
#define MUX_pin   A3
#define EC_ADC_READING     1
#define VIN    0
#define VOUT   1
// Code
HappyDay_Ladybug_EC::HappyDay_Ladybug_EC() {
    ads1015.begin(); // calls Wire.begin() and becomes I2C master
    ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
}
/*******************************************************************************/
// measure()
// assumes the EC probe is in the nutrient bath.  Gets the resistance returned from the EC probe by measuring
// the Vin created by the shrunked Wien Bridge waveform and Vout which is an amplified signal where one of the
// resistors is the EC probe.
/**********************************************************************************/
uint16_t HappyDay_Ladybug_EC::measure() {
    int16_t adc_result;
    myStats.clear();
    uint16_t EC_value = calcEC();
    return EC_value;
}
/*******************************************************************************/
// readEC()
// reading Vin and Vout involves switching which signal is feed into AIN1 of the ADS1015
/**********************************************************************************/
int HappyDay_Ladybug_EC::readEC(byte signal) {
    myStats.clear(); //explicitly start clean
    switchTo(signal);
    for (int i=0;i<100;i++) {
        int results;
        results = readADC(EC_ADC_READING);
        myStats.add(results);
    }
    return myStats.average();
}
/*******************************************************************************/
// switchTo()
// switch from reading Vin / Vout...the challenge is getting the signal stabilized after the switch.
// this is why there are delays with the values given.  I got to these values after analyzing the signals
// on a scope.
/**********************************************************************************/
void HappyDay_Ladybug_EC::switchTo(byte signal) {
    digitalWrite(FET_pin,LOW);
    if (signal == VIN)
        //switch to VIN
    {//when signal is low, VIN is read
        digitalWrite(MUX_pin,LOW);
    }
    else
    {
        digitalWrite(MUX_pin,HIGH);
    }
    //do some steps based on scope analysis: wait one second after switching
    delay(1000);
    //turn FET on and off to discharge the capacitor
    digitalWrite(FET_pin,HIGH);
    delay(1000);
    digitalWrite(FET_pin,LOW);
    //wait before taking a reading
    delay(10000);
}
/*******************************************************************************/
// calcEC()
// Gain = Vout/Vin...Both Vout and Vin are measured.. Then resistance of the EC probe = 1000./(Gain-1)  [here using
// Gain = 1+ Rf/Rg.  where Rf is the 1K known feedback resistor and Rg is the resistance the EC probe has acting as
// a variable resistor.
/**********************************************************************************/
uint16_t HappyDay_Ladybug_EC::calcEC() {
    Serial.println("--> calcEC");
    int EC_Vin = readEC(VIN);
    Serial.print(F("Vin: "));
    Serial.print(EC_Vin);
    int EC_Vout = readEC(VOUT);
    Serial.print(F(" | Vout: "));
    Serial.println(EC_Vout);

    //gain = VOUT/VIN
    float gain = (float)EC_Vout/(float)EC_Vin;
    //calculate the resistance value of the EC probe...the feedback resistor = 1K
    float ECR = 1000./(gain-1);
    float EC_in_Siemens = 1/ECR;
    //convert to µS
    uint16_t EC_in_microSiemens = EC_in_Siemens * 1000000;
    return (EC_in_microSiemens);
}
/*******************************************************************************/
// readADC(byte pH_or_EC)
// gets a reading from the ADS1015.  pH is on differential AIN0.  EC is on differentialAIN1
/**********************************************************************************/
int16_t HappyDay_Ladybug_EC::readADC(byte pH_or_EC){
    int16_t results = ads1015.readADC_Differential_VGND(pH_or_EC);
    return(results*LSB_mV);
}
