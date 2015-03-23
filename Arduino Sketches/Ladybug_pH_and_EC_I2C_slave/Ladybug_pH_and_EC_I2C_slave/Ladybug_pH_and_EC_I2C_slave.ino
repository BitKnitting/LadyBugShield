/************************************************************************************
 * Ladybug Shield I2C Slave that sends pH and EC value on request.
 *************************************************************************************/
#include <Statistic.h>
#include <avr/eeprom.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>
#define LSB_mV  1
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
#define LADYBUG_I2C_ADDRESS    0x8
#define BEAN_I2C_ADDRESS       0x9
uint8_t data[3]={
  0};
void setup()
{
  Serial.begin(9600);
  Wire.begin(LADYBUG_I2C_ADDRESS);
  Wire.onRequest(requestEvent);
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
{ //keep taking readings 
  float pH_value = takepHReading();
  Serial.print("pH: ");
  Serial.println(pH_value);
  pack(pH_value);
  delay(1000);
}

float takepHReading(){
  int16_t adc_result;
  myStats_pH.clear();
  for (int i=0;i<1000;i++) 
  {
    adc_result = readADC();
    myStats_pH.add(adc_result);
  }
  float pH = calc();
  return pH;
}

float calc()
{
  //  Serial.println("---> IN calcpH()");
  float stepsFrom7 = (myStats_pH.average()-params.pH7Cal)/params.pHStep;
  //  Serial.print("pH7Cal: ");
  //  Serial.print(params.pH7Cal);
  //  Serial.print(" | steps from pH 7: ");
  //  Serial.print(stepsFrom7);
  //  Serial.print(" | pHStep: ");
  //  Serial.println(params.pHStep);
  return( 7.-stepsFrom7);
}

void resetParams(void)
{
  Serial.println(F("---> IN resetParams"));
  //Restore to ideal parameters.
  params.WriteCheck = Write_Check;
  params.pH7Cal = 0; //pH 7 voltage = 0V
  params.pH4Cal = 177.36; //pH 4 voltage = 177.36mV
  params.pHStep = 59.16;//ideal probe slope
  eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
void readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep) {
  Serial.println(F("---> IN readParams"));
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  *pHStep = params.pHStep;
  *pH4Cal = params.pH4Cal;
  *pH7Cal = params.pH7Cal;
  Serial.print(F("pH Slope:"));
  Serial.println(*pHStep);
  Serial.print(F("pH 4 Cal:"));
  Serial.println(*pH4Cal);
  Serial.print(F("pH 7 Cal:"));
  Serial.println(*pH7Cal);
}
int16_t readADC(void){
  // ads1015.setGain(GAIN_ONE);     // 1x gain   +/- 4.096V  1 bit = 2mV
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
  // ads1015.setGain(GAIN_FOUR);    // 4x gain   +/- 1.024V  1 bit = 0.5mV
  // ads1015.setGain(GAIN_EIGHT);   // 8x gain   +/- 0.512V  1 bit = 0.25mV
  // ads1015.setGain(GAIN_SIXTEEN); // 16x gain  +/- 0.256V  1 bit = 0.125mV
  //pH is AIN0 on the ADS1015 of the Ladybug Shield
  //  Serial.println("before readADC");
  int16_t results = ads1015.readADC_Differential_VGND(0);
  //  Serial.println("after readADC");
  return(results*LSB_mV);
}
void pack(float pH) {
  uint8_t major = uint8_t(pH);
  uint8_t minor = 0;
  float temp = pH-major+.051;
  if (temp >= 1.) {
    major += 1.;
  }
  else {
    minor = (temp*10.) ;
  }
  data[0] = major << 4 | minor;
  Serial.print("pH byte: ");
  Serial.println(data[0],HEX);
}
void requestEvent()
{
  Serial.print("data byte: ");
  Serial.println(data[0],HEX);
  uint16_t ec_value = 5000;
  data[1] = ec_value >> 8;
  data[2] = ec_value;
  Wire.beginTransmission(BEAN_I2C_ADDRESS);
  Wire.write(data,3);
  Wire.endTransmission();

}












