//
// HappyDay_Ladybug_pH.cpp
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
// TODO: WARNING/ALERT? Probe potentially is bad / needs replacing

// Library header
#include <avr/eeprom.h>
#include "HappyDay_Ladybug_pH.h"
#include <Adafruit_ADS1015.h>
#include <Statistic.h>
Adafruit_ADS1015 ads1015;
Statistic myStats;

#define LSB_mV  1

// Code
HappyDay_Ladybug_pH::HappyDay_Ladybug_pH() {
    //get the calibrated slope values
    readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep);
    ads1015.begin(); // calls Wire.begin() and becomes I2C master
    ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
}
/*******************************************************************************/
// readParams
// get stored calibration values for the pH slope
/**********************************************************************************/
void HappyDay_Ladybug_pH::readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep) {
    eeprom_read_block(&params, (void *)0, sizeof(params));
    //if the values don't make sense, reset to default (note: leaving Write_Check but not using)
    if (!param_values_ok()) {
        resetParams();
        Serial.println(F("--> reset slope params to default"));
    }
    else {
          Serial.println(F("--> slope params did not need to be reset"));
    }
    *pHStep = params.pHStep;
    *pH4Cal = params.pH4Cal;
    *pH7Cal = params.pH7Cal;
    Serial.print(F("pH 4: "));
    Serial.print(*pH4Cal);
    Serial.print(F(" | pH7: "));
    Serial.print(*pH7Cal);
    Serial.print(F(" | Slope: "));
    Serial.println(*pHStep);
}
/*******************************************************************************/
// resetParams
// reset pH measurements to use "ideal" slope
/**********************************************************************************/
void HappyDay_Ladybug_pH::resetParams(void)
{
    //Restore to ideal parameters.
    params.WriteCheck = Write_Check;
    params.pH7Cal = ideal_pH7_mV(); //pH 7 voltage = 0V
    params.pH4Cal = ideal_pH4_mV(); //pH 4 voltage = 177.36mV
    params.pHStep = 59.16;//ideal probe slope
    eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
int HappyDay_Ladybug_pH::ideal_pH7_mV(){
    return 0.;
}
int HappyDay_Ladybug_pH::ideal_pH4_mV(){
    return 177;
}
/*******************************************************************************/
// readADC(byte pH_or_EC)
// gets a reading from the ADS1015.  pH is on differential AIN0.  EC is on differentialAIN1
/**********************************************************************************/
int16_t HappyDay_Ladybug_pH::readADC(byte pH_or_EC){
    int16_t results = ads1015.readADC_Differential_VGND(pH_or_EC);
    return(results*LSB_mV);
}
/*******************************************************************************/
// calcpH(int adc_value_read)
// uses the method described in minipH.ino to calculate the pH value
// see https://github.com/SparkysWidgets/MinipHBFW
/**********************************************************************************/
float HappyDay_Ladybug_pH::calcpH(int adc_value_read)
{
    float stepsFrom7 = (adc_value_read-params.pH7Cal)/params.pHStep;
    return( 7.-stepsFrom7);
}
/*******************************************************************************/
// update_calibration_params (byte pH_to_calibrate, float pH)
//This is really the heart of the calibration proccess, we want to capture the
//probes "age" and compare it to the Ideal Probe, the easiest way to capture two readings,
//at known point(4 and 7 for example) and calculate the slope.
//If your slope is drifting too much from Ideal(59.16) its time to clean or replace!
void HappyDay_Ladybug_pH::update_calibration_params (byte pH_to_calibrate, int pH_mV)
{
    Serial.println(F("-->update_calibration_params"));
    Serial.print(F("calibrating pH "));
    Serial.print(pH_to_calibrate);
    Serial.print(F("pH value: "));
    Serial.println(pH_mV);
    pH_to_calibrate == 4? params.pH4Cal = (float)pH_mV : params.pH7Cal = (float)pH_mV;
    params.pHStep = float(params.pH4Cal-params.pH7Cal)/3.; // 3 = 7-4 (steps between pH 4 and pH 7)
    eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
/*******************************************************************************/
// measure()
// assumes the pH probe is in the nutrient bath.  Gets the voltage value returned from the probe then
// converts to a pH value.  An average of readings is used to accomodate noise.
/**********************************************************************************/
#define PH_ADC_READING     0   //pH is on AIN0 of the ADS1015
float HappyDay_Ladybug_pH::measure(){
    int16_t adc_result;
    myStats.clear();
    for (int i=0;i<1000;i++)
    {
        adc_result = readADC(PH_ADC_READING);
        myStats.add(adc_result);
    }
    float pH = calcpH(myStats.average());
    return pH;
}
/*******************************************************************************/
// calibrate(byte pH_to_calibrate) pH_to_calibrate = 4 or 7
// assumes the pH probe is in the pH 4 or 7 calibration solution.
// converts stores it into the params structure as well as EEPROM for the point on the pH slope at pH_to_calibrate.  An average of readings is used to accomodate noise.
/**********************************************************************************/
void HappyDay_Ladybug_pH::calibrate(byte pH_to_calibrate){
    myStats.clear();
    int16_t adc_result;
    for (int i=0;i<2000;i++)
    {
        adc_result = readADC(PH_ADC_READING);
        myStats.add(adc_result);
    }
    update_calibration_params(pH_to_calibrate,myStats.average());
}
/******************************************************************************
 * param_values_ok checks to see if the values used in the calculation of the (pH) slope
 * are reasonable.
 * pH 7 should be around a 0 voltage.  pH 4 should be around 177mV
 * Based on information provided in this post: http://www.phadjustment.com/TArticles/pH_Probe_Service.html
 * "Generally speaking, when an offset of more than 30 mv (at 7.0 pH) develops or more than 2 minutes is required for a probe to stabilize in a
 *  buffer solution a probe has reached end of life or needs reconditioning."
 * ...I am "roughly checking" the stored values of pH 7 and pH 4 to see if they are > 40mV.  I will use 40 instead of 30 and do both pH7 and pH4 in case one was misread.
 * it also checks a "Write check" value to see if this is the first time the board has
 * been written to (most likely) or the values are corrupt (not as likely)
 * NOTE: In an earlier Arduino sketch, I was checking if the probe needed replacement using:
 * if (reading > 30 mV from what it should be || reading < -30 mV from what it should be) {bad probe}
 * I recall
 *******************************************************************************/
bool HappyDay_Ladybug_pH::param_values_ok() {
    if ( params.pH7Cal> ideal_pH7_mV()+40 || params.pH7Cal < ideal_pH7_mV()-40) return false;
    if (params.pH4Cal > ideal_pH4_mV()+40 || params.pH4Cal < ideal_pH4_mV()-40) return false;
    if (params.WriteCheck != 0x1234) return false;
    return true;
}