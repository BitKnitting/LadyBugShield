#include <Statistic.h>
#include <avr/eeprom.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>
#define LSB_mV  1
const unsigned long READ_PERIOD_IN_MS=500;
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
  // ads1015.setGain(GAIN_ONE);     // 1x gain   +/- 4.096V  1 bit = 2mV
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
  // ads1015.setGain(GAIN_FOUR);    // 4x gain   +/- 1.024V  1 bit = 0.5mV
  // ads1015.setGain(GAIN_EIGHT);   // 8x gain   +/- 0.512V  1 bit = 0.25mV
  // ads1015.setGain(GAIN_SIXTEEN); // 16x gain  +/- 0.256V  1 bit = 0.125mV 
  showHelp();
}
void loop()
{  
  serialHandler();
}
void serialHandler() {
  char inChar;
  if((inChar = Serial.read())>0) {
    switch (inChar) {
    case 'p':
    case 'P': 
    {
      takeReadings();
      float pH = calcpH();
      Serial.print("pHmV: ");
      Serial.print(myStats_pH.average());
      Serial.print(" | pH: ");
      Serial.print(pH);
      Serial.print(" | Count: ");
      Serial.print(myStats_pH.count());
      Serial.print(" | StDev: ");
      Serial.println(myStats_pH.pop_stdev());
      showHelp();
      break;
    }
    case 's': 
    case 'S':
      readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep);
      showHelp();
      break; 
    case '?':
    case 'h': // Display help
      showHelp();
      break;
    default:
      break;
    }
  }
}
void takeReadings(){
  Serial.print("\r\nEnter number of millis to take readings (0 = ");
  Serial.print(READ_PERIOD_IN_MS);
  Serial.println("ms)");
  while (Serial.available()==0);
  unsigned long readPeriodInMilliseconds = Serial.parseInt();
  if (readPeriodInMilliseconds <= 0)readPeriodInMilliseconds = READ_PERIOD_IN_MS;
  Serial.print(F("Read for "));Â
  displayMillisToMinutesAndSeconds(readPeriodInMilliseconds);
  Serial.print(F("\r\nHit any character to continue "));
  while (Serial.available()==0);
  readValuesToGetAvg(readPeriodInMilliseconds);
}
void readValuesToGetAvg(unsigned long pHReadreadPeriodInMilliseconds) {
  int16_t adc_result;
  unsigned long currentMillis = millis();
  unsigned long lastpHCalibrationMillis = currentMillis;
  myStats_pH.clear();
  while (currentMillis - lastpHCalibrationMillis < pHReadreadPeriodInMilliseconds)
  {
    //get a pH reading (assumes pH probe is in a calibration solution)
    adc_result = readADC();
    Serial.println(adc_result);
    myStats_pH.add(adc_result);
    currentMillis = millis();
  }
}
//TBD: Adjust for temperature
float calcpH()
{
  Serial.println("---> IN calcpH()");
  float stepsFrom7 = (myStats_pH.average()-params.pH7Cal)/params.pHStep;
  Serial.print("pH7Cal: ");
  Serial.print(params.pH7Cal);
  Serial.print(" | steps from pH 7: ");
  Serial.print(stepsFrom7);
  Serial.print(" | pHStep: ");
  Serial.print(params.pHStep);
  return( 7.-stepsFrom7);
}
//
void displayMillisToMinutesAndSeconds(unsigned long milliseconds) {
  int seconds = (int) (milliseconds / 1000) % 60 ;
  int minutes = (int) ((milliseconds / 60000) % 60);
  Serial.print(milliseconds);
  Serial.print(F(" milliseconds = "));
  if (minutes > 0) {
    Serial.print(minutes);
    Serial.print(F(" minutes and "));
  }
  Serial.print(seconds);
  Serial.print(F(" seconds "));
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
  int16_t results = ads1015.readADC_Differential_VGND(0);
  return(results*LSB_mV);
}



const char helpText[] PROGMEM =
"\n"
"Available commands:" "\n"
"  ?     - shows available comands" "\n"
"  p     - read pH" "\n"
"  s     - show config params" "\n"
;
/*-----------------------------------------------------------
 show command line menu
 -----------------------------------------------------------*/
static void showHelp () {
  showString(helpText);
}
static void showString (PGM_P s) {
  for (;;) {
    char c = pgm_read_byte(s++);
    if (c == 0)
      break;
    if (c == '\n')
      Serial.print('\r');
    Serial.print(c);
  }
}










