/*
Copyright Margaret Johnson 1/2015
*/
#include <Statistic.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>

Adafruit_ADS1015 ads1015;
const byte gate_pin = 8;
const byte ain_pin = 7;
const byte LSB_multiplier = 1;// 2x gain   +/- 2.048V  1 bit = 1mV
Statistic myStats_Vin;  //from http://playground.arduino.cc/Main/Statistics
Statistic myStats_ECv;
void setup(void)
{
  Serial.begin(9600);
  pinMode(gate_pin,OUTPUT);
  pinMode(ain_pin,OUTPUT);
  ads1015.begin();
  //Vpp a bit over 2V
  // ads1015.setGain(GAIN_ONE);     // 1x gain   +/- 4.096V  1 bit = 2mV
  ads1015.setGain(GAIN_TWO);     // 2x gain   +/- 2.048V  1 bit = 1mV
  // ads1015.setGain(GAIN_FOUR);    // 4x gain   +/- 1.024V  1 bit = 0.5mV
  // ads1015.setGain(GAIN_EIGHT);   // 8x gain   +/- 0.512V  1 bit = 0.25mV
  // ads1015.setGain(GAIN_SIXTEEN); // 16x gain  +/- 0.256V  1 bit = 0.125mV 
  showHelp();
}
void loop() 
{
  // Handle serial commands
  serialHandler();
}
void serialHandler() {
  char inChar;
  if((inChar = Serial.read())>0) {
    switch (inChar) {
    case 'r': // take reading
    case 'R':
      readEC();
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
#define VIN  1
#define ECV  2
void readEC()
{
  Serial.println("readEC");
  myStats_Vin.clear(); //explicitly start clean
  myStats_ECv.clear();
  Serial.println(F("Enter number readings: "));
  while (Serial.available () == 0) {
    ;
  }
  unsigned int num_readings = Serial.parseInt();
  Serial.println(num_readings);
  int vIn_value = readVIn(num_readings);
  Serial.print("Vin+: ");
  Serial.println(vIn_value);
  int vEC_value = readECv(num_readings);
  Serial.print(F("|  Count: "));
  Serial.print(myStats_Vin.count());
  Serial.print(F("**  Vin+ ** Average: "));
  Serial.print(myStats_Vin.average());
  Serial.print(F("|  Std deviation: "));
  Serial.print(myStats_Vin.pop_stdev());
  Serial.print(F("**  ECv ** Average: "));
  Serial.print(myStats_ECv.average());
  Serial.print(F("|  Std deviation: "));
  Serial.println(myStats_ECv.pop_stdev());
  float gain = (float)vEC_value/(float)vIn_value;   // G = Vout/Vin
  float rEC = (float)1000/(gain-1.);
  Serial.print(F("** Gain: "));
  Serial.print(gain);
  Serial.print(F("| ReC: "));
  Serial.print(rEC);
  Serial.print(F("|EC: "));
  float mS = 1/rEC*1000;
  Serial.print(mS);
  Serial.println("mS");
}
int readVIn(unsigned int num_readings)
{
  dischargeCapacitor();
  switchTo(VIN);
  for (int i=0;i<num_readings;i++) {
    int results = readADC();
    myStats_Vin.add(results);
  }
  return myStats_Vin.average();
}
int readECv(unsigned int num_readings)
{
  dischargeCapacitor();
  switchTo(ECV);
  for (int i=0;i<num_readings;i++) {
    int results = readADC();
    myStats_ECv.add(results);
  }
  return myStats_ECv.average();
}
int adcReading(unsigned int num_readings)
{
  for (int i=0;i<num_readings;i++) {
    int results = readADC();
    myStats_Vin.add(results);
  }
  return myStats_Vin.average();
}
void dischargeCapacitor()
{
  digitalWrite(gate_pin,HIGH); //Discharge the capacitor
  digitalWrite(gate_pin,LOW);  //Open the short circuit
}
void switchTo(const byte waveform)
{
  if (waveform == VIN) {
    Serial.println("Reading Vin+");
    digitalWrite(ain_pin,HIGH); //See the EC schematic
    delay(1000);
  }
  else {
    Serial.println("Reading ECv");
    digitalWrite(ain_pin,LOW); //default to ECv
    delay(1000);
  }
}
int16_t readADC()
{
  int16_t results = ads1015.readADC_Differential_VGND(0)*LSB_multiplier;
  Serial.println(results);
  return results;
}
const char helpText[] PROGMEM =
"\n"
"Available commands:" "\n"
"  ?     - shows available comands" "\n"
"  r     - take reading" "\n"
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









