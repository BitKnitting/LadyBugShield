#include <avr/eeprom.h>
#include <Wire.h>
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
enum UI_states_T
{
  ACTIVE,
  MONITOR,
  PUMP,
  INACTIVE
}
state;
float pH_min,pH_max;
unsigned int EC_min,EC_max;
void setup() {
  Serial.begin(9600);
  state = INACTIVE;
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
void loop(){
  handleState();
}

void handleState() {
  if (Serial.available() )
  {
    char c = Serial.read();
    switch(c) {
    case 'm':
    case 'M':
      pH_max = getFloat("pH max: ");
      pH_min = getFloat("pH min: ");
      EC_max = getUint("EC max (µS): ");
      EC_min = getUint("EC min (µS): ");
      state = MONITOR;
      break;
  case 'r':
  case 'R':

    break;
  }
  switch(state) {
    case MONITOR:
    {
      float pH_value = takepHReading();
       uint16_t EC_value = takeECReading();
       if (pH_value > pH_max || pH_value < pH_min)
       {
       adjustpH(pH_value);
       }
       if (EC_value > EC_max || EC_value < EC_moin)
       {
         adjustEC(EC_value);
       }
    }
    checkReadings();
    break;
    case PUMP:
    pump();
    break;
}


float getFloat(char *value_to_get)
{
  Serial.print(F("Enter "));
  Serial.print(value_to_get);
  Serial.println(F(": "));
  while (Serial.available () == 0) {
    ;
  }
  float value = Serial.parseFloat();
  return value;
}
unsigned int getUint(char *value_to_get)
{
  Serial.print(F("Enter "));
  Serial.print(value_to_get);
  Serial.println(F(": "));
  while (Serial.available () == 0) {
    ;
  }
  unsigned int value = Serial.parseInt();
  return value;
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
}
/**************************************************************************/
/*!
 @brief  takepHReading
 */
#pragma mark -- takepHReading
/**************************************************************************/
float takepHReading(){
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
/**************************************************************************/
/*!
 @brief  takeECReading
 */
/**************************************************************************/
unsigned int takeECReading(void){
    int adc_result;
    myStats.clear();
    uint EC_value = calcEC();
    return EC_value;
}
/**************************************************************************/
/*!
 @brief  readADC
 */
#pragma mark -- readADC
/**************************************************************************/
int readADC(char pH_or_EC) {
    int results = ads1015.readADC_Differential_VGND(pH_or_EC);
    return(results*LSB_mV);
}
/**************************************************************************/
/*!
 @brief  calcpH
 */
#pragma mark -- calcpH
/**************************************************************************/
float calcpH(int adc_result) {
    float stepsFrom7 = (adc_result-params.pH7Cal)/params.pHStep;
    return( 7.-stepsFrom7);
}
/**************************************************************************/
/*!
 @brief  calcEC
 */
#pragma mark -- calcEC
/**************************************************************************/
unsigned int calcEC() {
    int EC_Vin = readEC(VIN);
    int EC_Vout = readEC(VOUT);
    //gain = VOUT/VIN
    float gain = (float)EC_Vout/(float)EC_Vin;
    //calculate the resistance value of the EC probe...the feedback resistor = 1K
    float ECR = 1000./(gain-1);
    float EC_in_Siemens = 1/ECR;
    //convert to µS
    unsigned int EC_in_microSiemens = EC_in_Siemens * 1000000;
    return (EC_in_microSiemens);
}
/**************************************************************************/
/*!
 @brief  readEC
 */
#pragma mark -- readEC
/**************************************************************************/
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
/**************************************************************************/
/*!
 @brief  switchTo The delays that are included came about after analyzing the behavior
 of the MUX and the FET...observations pointed to these delays "working best"...be careful
 about twiggling the values. The current values were best at accuracy AND precision.
 */
#pragma mark -- switchTo
/**************************************************************************/
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
    //based on scope analysis: wait one second after switching
      delay(1000);
    //turn FET on and off to discharge the capacitor
    digitalWrite(FET_pin,HIGH);
      delay(1000);
    digitalWrite(FET_pin,LOW);
    //wait before taking a reading
      delay(5000);
}

