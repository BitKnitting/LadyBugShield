/*******************************************************************************/
//Ladybug Shield BLE Slave V1 - read pH and EC, set BLE advertising name (TBD: 
//data in advertisement packet)
//- uses RedBearLab BLE Shield and RBL BLE library
//- uses Adafruit's ADS1015 library
//- proof of concept
//- copyright Margaret Johnson 3/2015
//- TBD: License
/**********************************************************************************/
#define DEBUG 1
#ifdef DEBUG
#define DEBUG_PRINT(x)  Serial.print (x)
#define DEBUG_PRINTHEX(x) Serial.print(x,HEX)
#define DEBUG_PRINTF(x) Serial.print(F(x))
#define DEBUG_PRINTLN(x) Serial.println(x)
#define DEBUG_PRINTLNF(x) Serial.println(F(x))
#else
#define DEBUG_PRINT(x)
#define DEBUG_PRINTF(x)
#define DEBUG_PRINTLN(x)
#define DEBUG_PRINTLNF(x)
#define DEBUG_PRINTHEX(x)
#endif
#include <SPI.h>
#include <boards.h>
#include <RBL_nRF8001.h>


#include <avr/eeprom.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>  //Thank you Adafruit for making access to the ADS1015 easy:http://www.adafruit.com/product/1083 
#include <Statistic.h>
#define  FET_pin  A1
#define MUX_pin   A3
#define PH_ADC_READING     0
#define EC_ADC_READING     1
#define VIN    1
#define VOUT   2
#define LSB_mV  1
#define Write_Check      0x1234
Adafruit_ADS1015 ads1015;
Statistic myStats;
struct parameters_T
{
  unsigned int WriteCheck;
  int16_t pH7Cal, pH4Cal;
  float pHStep;
}
params;

/**********************************************************************************/
void setup()
{
  Serial.begin(9600);
  DEBUG_PRINTLNF("***************************");
  DEBUG_PRINTLNF("Ladybug Shield BLE Slave V1");
  DEBUG_PRINTF("Amount of RAM left: ");
  DEBUG_PRINTLN(freeRam());
  DEBUG_PRINTLNF("***************************");
  // Default pins set to 9 and 8 for REQN and RDYN
  // Set your REQN and RDYN here before ble_begin() if you need
  //ble_set_pins(3, 2);
  Ladybug_begin();
  ble_begin();
}
/**********************************************************************************/
void loop() 
{//don't do anything until BLE is ready
  if (ble_isAdvertising())
  {
    float pH_value = takepHReading();
    DEBUG_PRINTF("--> pH: ");
    DEBUG_PRINTLN(pH_value);
    uint16_t EC_value = takeECReading();
    DEBUG_PRINTF("--> EC: ");
    DEBUG_PRINTLN(EC_value); 
    setBLEAdvertisementName(pH_value,EC_value);   
    DEBUG_PRINTLNF("Wait before taking another reading...");
    delay(10000); //take a break
  }
  ble_do_events();
}
/*******************************************************************************/
// Ladybug_begin
// This sets up calibration info, gets the pins ready, starts up the ADC.
// readParams/resetParams come from Ryan's @SparkysWidgets minipH - see https://github.com/SparkysWidgets/MinipHBFW
/**********************************************************************************/
void Ladybug_begin()
{
  DEBUG_PRINTLNF("--> Ladybug_begin()");
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  //get the calibrated slope values
  readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep);
  DEBUG_PRINTF("Calibration values for pH 4: ");
  DEBUG_PRINT(params.pH4Cal);
  DEBUG_PRINTF(" | pH7: ");
  DEBUG_PRINT(params.pH7Cal);
  DEBUG_PRINTF(" | slope: ");
  DEBUG_PRINTLN(params.pHStep);
  ads1015.begin(); // calls Wire.begin() and becomes I2C master
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
  pinMode(FET_pin,OUTPUT);
  pinMode(MUX_pin,OUTPUT);
}
/*******************************************************************************/
// readParams
// used by Ladybug_begin to get stored calibration values for the pH slope
/**********************************************************************************/
void readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep) {
  DEBUG_PRINTLNF("--> readParams()");
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  *pHStep = params.pHStep;
  *pH4Cal = params.pH4Cal;
  *pH7Cal = params.pH7Cal;
}
/*******************************************************************************/
// resetParams
// used by Ladybug_begin to reset pH measurements to use "ideal" slope
/**********************************************************************************/
void resetParams(void)
{
  DEBUG_PRINTLNF("--> resetParams()");
  //Restore to ideal parameters.
  params.WriteCheck = Write_Check;
  params.pH7Cal = 0; //pH 7 voltage = 0V
  params.pH4Cal = 177.36; //pH 4 voltage = 177.36mV
  params.pHStep = 59.16;//ideal probe slope
  eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
/*******************************************************************************/
// takepHReading()
// assumes the pH probe is in the nutrient bath.  Gets the voltage value returned from the probe then
// converts to a pH value.  An average of readings is used to accomodate noise.
/**********************************************************************************/
float takepHReading(){
  DEBUG_PRINTLNF("--> takepHReading()");
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
// takeECReading()
// assumes the EC probe is in the nutrient bath.  Gets the resistance returned from the EC probe by measuring
// the Vin created by the shrunked Wien Bridge waveform and Vout which is an amplified signal where one of the
// resistors is the EC probe. 
/**********************************************************************************/
uint16_t takeECReading() {
  DEBUG_PRINTLNF("--> takeECReading()");
  int16_t adc_result;
  myStats.clear();
  uint16_t EC_value = calcEC();
  return EC_value;
} 
/*******************************************************************************/
// calcEC()
// Gain = Vout/Vin...Both Vout and Vin are measured.. Then resistance of the EC probe = 1000./(Gain-1)  [here using
// Gain = 1+ Rf/Rg.  where Rf is the 1K known feedback resistor and Rg is the resistance the EC probe has acting as
// a variable resistor.
/**********************************************************************************/
uint16_t calcEC() {
  DEBUG_PRINTLNF("--> calcEC()");
  int EC_Vin = readEC(VIN);
  DEBUG_PRINTF("--> Vin: ");
  DEBUG_PRINTLN(EC_Vin);
  int EC_Vout = readEC(VOUT);
  DEBUG_PRINTF("--> Vout: ");
  DEBUG_PRINTLN(EC_Vout);
  //gain = VOUT/VIN
  float gain = (float)EC_Vout/(float)EC_Vin;
  DEBUG_PRINTF("| --> gain: ");
  DEBUG_PRINT(gain);
  //calculate the resistance value of the EC probe...the feedback resistor = 1K
  float ECR = 1000./(gain-1);
  DEBUG_PRINTF(" | EC probe resistance: ");
  DEBUG_PRINTLN(ECR);
  float EC_in_Siemens = 1/ECR;
  //convert to µS
  uint16_t EC_in_microSiemens = EC_in_Siemens * 1000000;
  return (EC_in_microSiemens);
}
/*******************************************************************************/
// readEC()
// reading Vin and Vout involves switching which signal is feed into AIN1 of the ADS1015
/**********************************************************************************/
int readEC(byte signal) {
  DEBUG_PRINTLNF("--> readEC()");
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
void switchTo(byte signal) {
  DEBUG_PRINTLNF("--> switchTo()");
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
  delay(5000);
}
/*******************************************************************************/
// setBLEAdvertisementName()
// convert the pH and EC values to a string and separate with a comma then set the BLE advertisement name
/**********************************************************************************/
void setBLEAdvertisementName(float pH_value,float EC_value)
{
  DEBUG_PRINTLNF("--> setBLEAdvertisementName()");
  char pH_and_EC_str[20] = {
    0    };
    //the advertisement name is limited to 10 characters..so optimize use of characters)
    byte pH_string_length = 3;
    if (pH_value >= 10.) pH_string_length = 4;
  dtostrf(pH_value,pH_string_length,1,pH_and_EC_str);
  strcat(pH_and_EC_str,",");
  char buffer[10] = {
    0                };
  utoa(EC_value,buffer,10);
  strcat(pH_and_EC_str,buffer);
  DEBUG_PRINTF("pH and EC: ");
  DEBUG_PRINTLN(pH_and_EC_str);
  ble_set_name(pH_and_EC_str);
}
/*******************************************************************************/
// calcpH(int adc_value_read)
// uses the method described in minipH.ino to calculate the pH value
// see https://github.com/SparkysWidgets/MinipHBFW
/**********************************************************************************/
float calcpH(int adc_value_read)
{
  DEBUG_PRINTLNF("--> calcpH()");
  float stepsFrom7 = (adc_value_read-params.pH7Cal)/params.pHStep;
  return( 7.-stepsFrom7);
}
/*******************************************************************************/
// readADC(byte pH_or_EC)
// gets a reading from the ADS1015.  pH is on differential AIN0.  EC is on differentialAIN1
/**********************************************************************************/
int16_t readADC(byte pH_or_EC){
  int16_t results = ads1015.readADC_Differential_VGND(pH_or_EC);
  return(results*LSB_mV);
}
/*******************************************************************************/
// freeRam()
// the amount of RAM on an Arduino is a precious resource.
// see https://bitknitting.wordpress.com/2013/11/14/better-together-arduino-unosd-shieldcc3000rfm12b/
/**********************************************************************************/
int freeRam () {
  extern int __heap_start, *__brkval;
  int v;
  return (int)&v - (__brkval ==0 ? (int) &__heap_start : (int) __brkval);
}













