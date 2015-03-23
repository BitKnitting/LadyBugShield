#include <avr/eeprom.h>
#include <Wire.h>
#define  Bean_I2C_Address  4
#include <Adafruit_ADS1015.h>
#include <Statistic.h>
#define  FET_pin  A1
#define MUX_pin   A3
#define LSB_mV  1
////EEPROM trigger check
#define Write_Check      0x1234
#define VIN    1
#define VOUT   2
#define PH_ADC_READING     0
#define EC_ADC_READING     1
Adafruit_ADS1015 ads1015;
Statistic myStats;
struct parameters_T
{
  unsigned int WriteCheck;
  int16_t pH7Cal, pH4Cal;
  float pHStep;
}
params;
uint8_t data[3]={
  0};
void setup()
{
  Serial.begin(9600);
  //Lets read our Info from the eeprom and setup our params,
  //if we loose power or reset we'll still remember our settings!
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  //get the calibrated slope values
  readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep);
  ads1015.begin(); // calls Wire.begin() and becomes I2C master
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
  pinMode(FET_pin,OUTPUT);
  pinMode(MUX_pin,OUTPUT);
}

void loop()
{
  float pH_value = takepHReading();
  Serial.print("--> pH: ");
  Serial.println(pH_value);
  uint16_t EC_value = takeECReading();
//uint16_t EC_value = 2000;
  packAndSend(pH_value,EC_value);
  delay(500);
}
float takepHReading(){
  int16_t adc_result;
  myStats.clear();
  for (int i=0;i<1000;i++) 
  {
    adc_result = readADC(PH_ADC_READING);
    myStats.add(adc_result);
  }
  float pH = calcpH();
  return pH;
}
float calcpH()
{
  //  Serial.println("---> IN calcpH()");
  float stepsFrom7 = (myStats.average()-params.pH7Cal)/params.pHStep;
  //  Serial.print("pH7Cal: ");
  //  Serial.print(params.pH7Cal);
  //  Serial.print(" | steps from pH 7: ");
  //  Serial.print(stepsFrom7);
  //  Serial.print(" | pHStep: ");
  //  Serial.println(params.pHStep);
  return( 7.-stepsFrom7);
}
uint16_t takeECReading() {
  int16_t adc_result;
  myStats.clear();
  uint16_t EC_value = calcEC();
  return EC_value;
} 
uint16_t calcEC() {
  int EC_Vin = readEC(VIN);
  Serial.print("--> Vin: ");
  Serial.print(EC_Vin);
  int EC_Vout = readEC(VOUT);
  Serial.print(" | Vout: ");
  Serial.println(EC_Vout);
  //gain = VOUT/VIN
  float gain = (float)EC_Vout/(float)EC_Vin;
  Serial.print("--> Gain: ");
  Serial.print(gain);
  //calculate the resistance value of the EC probe...the feedback resistor = 1K
  float ECR = 1000./(gain-1);
  Serial.print(" | EC R: ");
  Serial.print(ECR);
  float EC_in_Siemens = 1/ECR;
  Serial.print(" | EC in Siemens: ");
  Serial.println(EC_in_Siemens);
  
  //convert to µS
  uint16_t EC_in_microSiemens = EC_in_Siemens * 1000000;
  Serial.print("---> EC: ");
  Serial.println(EC_in_microSiemens);
  return (EC_in_microSiemens);
}
int readEC(byte signal) {
  myStats.clear(); //explicitly start clean
  switchTo(signal);
  for (int i=0;i<100;i++) {
    int results;
    results = readADC(EC_ADC_READING);
    myStats.add(results);
  }
  return myStats.average();
}
void switchTo(byte signal) {
  //don't drain rectified results to GND
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
//  delay(1000);
  //turn FET on and off to discharge the capacitor
  digitalWrite(FET_pin,HIGH);
//  delay(1000);
  digitalWrite(FET_pin,LOW);
  //wait before taking a reading
//  delay(5000);
}
int16_t readADC(byte AN pH_or_EC){
  //pH is AIN0 on the ADS1015 of the Ladybug Shield
  int16_t results = ads1015.readADC_Differential_VGND(pH_or_EC);
  return(results*LSB_mV);
}
void packAndSend(float pH,uint16_t EC) {
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
  uint16_t ec_value = EC;
  data[1] = ec_value >> 8;
  data[2] = ec_value;
  Wire.beginTransmission(Bean_I2C_Address);
  Wire.write(data,3);
  Wire.endTransmission();
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
//  Serial.print(F("pH Slope:"));
//  Serial.println(*pHStep);
//  Serial.print(F("pH 4 Cal:"));
//  Serial.println(*pH4Cal);
//  Serial.print(F("pH 7 Cal:"));
//  Serial.println(*pH7Cal);
}


