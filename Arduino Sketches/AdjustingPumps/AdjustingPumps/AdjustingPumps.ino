/*************************************************************************************/
//pHDown.ino
//adjust the pH of a nutrient bath down
//Copyright Margaret Johnson  3/2015
//thanks to:
//  SparkysWidgets for the open source minipH Arduino sketch: https://github.com/SparkysWidgets/MinipHBFW
//  Adafruit for the ADS1015 BOB, tutorial and library: https://learn.adafruit.com/adafruit-4-channel-adc-breakouts
/*************************************************************************************/
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
#include <Statistic.h>
#include <avr/eeprom.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>
#define LSB_mV  1
const unsigned long READ_PERIOD_IN_MS=500;
Adafruit_ADS1015 ads1015;
Statistic myStats;
//EEPROM trigger check
#define Write_Check      0x1234
struct parameters_T
{
  unsigned int WriteCheck;
  int16_t pH7Cal, pH4Cal;
  float pHStep;
  float pHDOWN;          //the pH DOWN is in a container that will be used until empty.  So save the pH DOWN value across readings.
}
params;
#define pH_DOWN_pin  7
float pH_nutrients=0.,pH_DOWN=0.,pH_set_point=0.;
float mS_to_pump=0.;
void setup()
{
  Serial.begin(9600);
  pinMode(pH_DOWN_pin,OUTPUT);
  //Lets read our Info from the eeprom and setup our params,
  //if we loose power or reset we'll still remember our settings!
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  //get the calibrated slope values
  readParams(&params.pH4Cal,&params.pH7Cal,&params.pHStep,&params.pHDOWN);
  pH_DOWN = params.pHDOWN;
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
    DEBUG_PRINTF("Character read: ");
    DEBUG_PRINTLN(inChar);
    switch (inChar) {
    case 's':
    case 'S': 
      {
        pH_set_point = 0.;
        Serial.println(F("\r\nEnter pH to set nutrients: "));
        while (Serial.available()==0);
        pH_set_point = Serial.parseFloat();
        DEBUG_PRINTF("pH set point: ");
        DEBUG_PRINTLN(pH_set_point);
        showHelp();
      }
      break;
    case 'p':
    case 'P': 
      {
        takeReadings(READ_PERIOD_IN_MS);
        pH_nutrients = calcpH();
        DEBUG_PRINTF("pHmV: ");
        DEBUG_PRINT(myStats.average());
        DEBUG_PRINTF(" | pH: ");
        DEBUG_PRINT(pH_nutrients);
        DEBUG_PRINTF(" | Count: ");
        DEBUG_PRINT(myStats.count());
        DEBUG_PRINTF(" | StDev: ");
        DEBUG_PRINTLN(myStats.pop_stdev());
        showHelp();
      }
      break;
    case 'd': 
    case 'D':
      {
        takeReadings(READ_PERIOD_IN_MS);
        pH_DOWN = calcpH();
        params.pHDOWN = pH_DOWN;
        //the pH DOWN is in a container that will be used until empty.  So save the pH DOWN value across readings.
        eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
        DEBUG_PRINTF("--> pH Down saved in EEPROM: ");
        DEBUG_PRINTLN(params.pHDOWN);
        DEBUG_PRINTF("pHmV: ");
        DEBUG_PRINT(myStats.average());
        DEBUG_PRINTF(" | pH: ");
        DEBUG_PRINT(pH_DOWN);
        DEBUG_PRINTF(" | Count: ");
        DEBUG_PRINT(myStats.count());
        DEBUG_PRINTF(" | StDev: ");
        DEBUG_PRINTLN(myStats.pop_stdev());
        showHelp();
      }
      break;
    case 'n':
    case 'N':
      {
        DEBUG_PRINTF("pH Nutrient value: ");
        DEBUG_PRINTLN(pH_nutrients);
        DEBUG_PRINTF("pH DOWN value: ");
        DEBUG_PRINTLN(pH_DOWN);
        DEBUG_PRINTF("pH Set point: ");
        DEBUG_PRINTLN(pH_set_point);
        if (pH_nutrients <= 0.) {
          Serial.println(F("---> first take pH measurement of nutrient bath"));
          showHelp();
          break;
        }
        if (pH_set_point <= 0.) {
          Serial.println(F("---> first enter pH set point"));
          showHelp();
          break;
        }       
        if (pH_DOWN <= 0.) {
          Serial.println(F("---> first take pH measurement of pH DOWN"));
          showHelp();
          break;
        }    
        mS_to_pump = calcPumpTime(pH_nutrients,pH_DOWN,pH_set_point);
        DEBUG_PRINTF("Number of milliseconds to pump: ");
        DEBUG_PRINTLN(mS_to_pump);
        showHelp();
        break; 
      }
    case 'u': 
    case 'U':
      {
        DEBUG_PRINTF("Number of milliseconds to pump: ");
        unsigned long pump_time = (unsigned long)(mS_to_pump+0.5);
        DEBUG_PRINTLN(pump_time);
        DEBUG_PRINTLNF("Start pumping");
        pump(pump_time);
        DEBUG_PRINTLNF("End pumping");
        showHelp();
      }
      break;
    case 'r':
    case 'R':
      print_params(params.pHStep,params.pH4Cal,params.pH7Cal,params.pHDOWN);
      break;
    case '?':
      showHelp();
      break;
    default:
      break;
    }
  }
}
void takeReadings(unsigned long pHReadreadPeriodInMilliseconds){
  int16_t adc_result;
  unsigned long currentMillis = millis();
  unsigned long lastpHCalibrationMillis = currentMillis;
  myStats.clear();
  while (currentMillis - lastpHCalibrationMillis < pHReadreadPeriodInMilliseconds)
  {
    //get a pH reading (assumes pH probe is in a calibration solution)
    adc_result = readADC();
    myStats.add(adc_result);
    currentMillis = millis();
  }
}
int16_t readADC(void){
  //pH is AIN0 on the ADS1015 of the Ladybug Shield
  int16_t results = ads1015.readADC_Differential_VGND(0);
  return(results*LSB_mV);
}
float calcpH()
{
  float stepsFrom7 = (myStats.average()-params.pH7Cal)/params.pHStep;
  return( 7.-stepsFrom7);
}
void resetParams(void)
{
  DEBUG_PRINTLNF("---> IN resetParams");
  //Restore to ideal parameters.
  params.WriteCheck = Write_Check;
  params.pH7Cal = 0; //pH 7 voltage = 0V
  params.pH4Cal = 177.36; //pH 4 voltage = 177.36mV
  params.pHStep = 59.16;//ideal probe slope
  params.pHDOWN = 0.; //the pH value of the pH DOWN for pumping needs to be measured.
  eeprom_write_block(&params, (void *)0, sizeof(params)); //write these settings back to eeprom
}
void readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep,float *pHDOWN) {
  DEBUG_PRINTLNF("---> IN readParams");
  eeprom_read_block(&params, (void *)0, sizeof(params));
  //if its a first time setup or our magic number in eeprom is wrong reset to default
  if (params.WriteCheck != Write_Check){
    resetParams();
  }
  *pHStep = params.pHStep;
  *pH4Cal = params.pH4Cal;
  *pH7Cal = params.pH7Cal;
  *pHDOWN = params.pHDOWN;
  print_params(*pHStep,*pH4Cal,*pH7Cal,*pHDOWN);
}
void print_params(int16_t pH4Cal,int16_t pH7Cal,float pHStep, float pHDOWN)
{
  DEBUG_PRINTF("pH Slope: ");
  DEBUG_PRINTLN(pHStep);
  DEBUG_PRINTF("pH 4 Cal: ");
  DEBUG_PRINTLN(pH4Cal);
  DEBUG_PRINTF("pH 7 Cal: ");
  DEBUG_PRINTLN(pH7Cal);
  DEBUG_PRINTF("pH DOWN: ");
  DEBUG_PRINTLN(pHDOWN);
}

float calcPumpTime(float pH_nutrients,float pH_DOWN,float pH_set_point)
{
  float H_concentration_for_pumping = pow(10.0,-pH_DOWN);
   DEBUG_PRINTLN(H_concentration_for_pumping);
  //pump about 1mL in 1 second
  float H_concentration_added_in_1_second = H_concentration_for_pumping * 1000.;
  DEBUG_PRINTF("The amount of concentration that is added in one second of pumping: ");
  DEBUG_PRINT(H_concentration_added_in_1_second);
  DEBUG_PRINTLNF("moles/liter");
  float H_concentration_current = pow(10.0,-pH_nutrients);
  float H_concentration_set_point = pow(10.0,-pH_set_point); //should be lower than what nutrients currently is at
  //subtract where we are from where we want to be. This gives us the amount of hydronium ions we need to add
  float H_concentration_to_add = H_concentration_set_point - H_concentration_current; //in moles/liter
  //1 gal = 3.8L
  //3 gallon bucket
  //units now in moles/3 gallons
H_concentration_to_add =  H_concentration_to_add*3.8*3;
//in mS
 float pump_time = H_concentration_to_add/H_concentration_added_in_1_second*1000;
 

  //
  //calculate amount (mL)  of pH DOWN (given measured concentration) to pump into nutrient bath
  //Assume 3 gallon bath
  // *3 to go from 1 L to 3 L
  // *3.8 to go from Liters to Gallons
  // * 1000 to go from liters to mLs
  // * 1000 to go from seconds to mS
//  float pump_time = 3.8*3.*1000.*(H_concentration_to_add/H_concentration_DOWN)*1000;
  return (pump_time);
}
void pump(unsigned long pump_time)
{
  digitalWrite(pH_DOWN_pin, HIGH);
  DEBUG_PRINTF("Pumping for ");
  DEBUG_PRINT(pump_time);
  DEBUG_PRINTLNF("mS");
  delay(pump_time);
  digitalWrite(pH_DOWN_pin, LOW);
}
const char helpText[] PROGMEM =
"\n"
"Available commands:" "\n"
"  ?     - shows available comands" "\n"
"  s     - pH set point" "\n"
"  d     - measure pH of pH DOWN - put probe in pH DOWN" "\n"
"  p     - measure pH of nutrient bath - put probe in nutrient bath" "\n"
"  n     - calculate number of seconds to pump" "\n"
"  u     - pump" "\n"
"  r     - show params" "\n"
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


















