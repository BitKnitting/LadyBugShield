/**************************************************************************************
 * Get a pH reading and make it available over I2C
 * Copyright Margaret Johnson   3/2015  
 */
#include <Statistic.h>
#include <avr/eeprom.h>
#include <Wire.h>  //I2C used by the ADS1015 and the Shield (to send the pH value to the Bean)
#include <Adafruit_ADS1015.h>
#define LSB_mV  1  //Resolution of ADC = 1mV
#define  i2cAddress  2

Adafruit_ADS1015 ads1015;
Statistic myStats_pH;
//EEPROM trigger check
#define Write_Check      0x1234
struct parameters_T
{
  unsigned int WriteCheck;
  int16_t pH7Cal, pH4Cal;
  float pHStep;
}
params;

void setup()
{
  Serial.begin(9600);
  Wire.begin(i2cAddress);                // join i2c bus with address #2
  Wire.onRequest(requestEvent); // register event
  //Lets read our Info from the eeprom and setup our params,
  //if we loose power or reset we'll still remember our settings!
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  //get the calibrated slope values
  readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep);
  ads1015.begin();
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
}
void loop()
{  

}
// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent()
{
  takeReadings();
  Serial.print("Average of readings: ");
  Serial.println(myStats_pH.average());
  float pH = calc();
  Serial.print("pH :");
  Serial.println(pH);
  packageAndSend(pH);

}
void takeReadings(){
  int16_t adc_result;
  myStats_pH.clear();
  for (int i=0;i<1000;i++) 
  {
    //get a pH reading (assumes pH probe is in a calibration solution)
//    adc_result = readADC();
adc_result = 1000;
    myStats_pH.add(adc_result);
  }
}
float calc()
{
  float stepsFrom7 = (myStats_pH.average()-params.pH7Cal)/params.pHStep;
  return( 7.-stepsFrom7);
}
//
void packageAndSend(float pH) {
  uint8_t major = uint8_t(pH);
  uint8_t minor = 0;
  float temp = pH-major+.051;
  if (temp >= 1.) {
    major += 1.;
  }
  else {
    minor = (temp*10.) ;
  }
  uint8_t pH_package = major << 4 | minor;
  Wire.write(pH_package);
}
void resetParams(void)
{
  params.WriteCheck = Write_Check;
  params.pH7Cal = 0; //pH 7 voltage = 0V
  params.pH4Cal = 177.36; //pH 4 voltage = 177.36mV
  params.pHStep = 59.16;//ideal probe slope
  eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
void readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep) {
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  *pHStep = params.pHStep;
  *pH4Cal = params.pH4Cal;
  *pH7Cal = params.pH7Cal;
}
int16_t readADC(void){
  int16_t results = ads1015.readADC_Differential_VGND(0);
  return(results*LSB_mV);
}














