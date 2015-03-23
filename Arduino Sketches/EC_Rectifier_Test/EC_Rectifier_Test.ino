/*
Copyright Margaret Johnson 1/2015
 */
#include <Statistic.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>

Adafruit_ADS1015 ads1015;
const byte FET_pin = A1;
const byte mux_out_pin = A3;
const byte mux_enable_pin = A2;
const byte LSB_multiplier = 1;// 2x gain   +/- 2.048V  1 bit = 1mV
Statistic myStats_Vin;  //from http://playground.arduino.cc/Main/Statistics
Statistic myStats_ECv;
void setup(void)
{
  Serial.begin(9600);
  pinMode(FET_pin,OUTPUT);
  digitalWrite(FET_pin,LOW); //start with FET as open circuit
  pinMode(mux_out_pin,OUTPUT);
  pinMode(mux_enable_pin,OUTPUT); 
  digitalWrite(mux_enable_pin,LOW); //This is always true right now in testing.  Disabled pull up.

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
    case 'i': // take ECVin+ reading
    case 'I':
      readECVin();
      showHelp();
      break;
    case 'o': // take ECVout reading
    case 'O':
      readECVout();
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

void readECVin()
{
  Serial.println("readECVin");
  myStats_Vin.clear(); //explicitly start clean
  Serial.println(F("Enter number readings: "));
  while (Serial.available () == 0) {
    ;
  }
  unsigned int num_readings = Serial.parseInt();
  Serial.println(num_readings);
  int vIn_value = readVIn(num_readings);
  Serial.print(F("|  Count: "));
  Serial.print(myStats_Vin.count());
  Serial.print(F("**  Vin+ ** Average: "));
  Serial.print(myStats_Vin.average());
  Serial.print(F("|  Std deviation: "));
  Serial.println(myStats_Vin.pop_stdev());
}
void readECVout()
{
  Serial.println("readECVout");
  myStats_ECv.clear(); //explicitly start clean
  Serial.println(F("Enter number readings: "));
  while (Serial.available () == 0) {
    ;
  }
  unsigned int num_readings = Serial.parseInt();
  Serial.println(num_readings);
  int vIn_value = readECv(num_readings);
  Serial.print(F("|  Count: "));
  Serial.print(myStats_ECv.count());
  Serial.print(F("**  ECVout ** Average: "));
  Serial.print(myStats_ECv.average());
  Serial.print(F("|  Std deviation: "));
  Serial.println(myStats_ECv.pop_stdev());

}
int readVIn(unsigned int num_readings)
{

  switchTo(VIN);
  Serial.println("-->settle ADC reading...");
  for (int j = 0;j<5;j++) {
    discharge();
    for (int i=0;i<100;i++) {
      readADC();
    }
  }
  for (int i=0;i<2000;i++) {
    readADC();
  }
  Serial.println("-->Start reading ADC...");  
  for (int i=0;i<num_readings;i++) {
    int results;
    //    discharge();
    results = readADC();
    //    if (i >= 200) {
    //    do {
    //      results = readADC();
    //      if (results > 350) Serial.println("Result for Vin+ > 350mV");
    //    }
    //    while (results > 350);
    myStats_Vin.add(results);
    //    }
  }
  discharge();
  return myStats_Vin.average();
}
int readECv(unsigned int num_readings)
{
  switchTo(ECV);
  Serial.println("-->settle ADC reading...");
  for (int j = 0;j<5;j++) {
    discharge();
    for (int i=0;i<100;i++) {
      readADC();
    }
  }
  for (int i=0;i<2000;i++) {
    readADC();
  }
  Serial.println("-->Start reading ADC...");  
  for (int i=0;i<num_readings;i++) {
    int results = readADC();
    myStats_ECv.add(results);
  }
  return myStats_ECv.average();
}
void switchTo(const byte waveform)
{
  Serial.println("Switch");
  if (waveform == VIN) {
    Serial.println("Reading Vin+");
    digitalWrite(mux_out_pin,LOW);  //ECVin+ when pin is low.
  }
  else {
    Serial.println("Reading ECv");
    digitalWrite(mux_out_pin,HIGH); //ECVout when pin is high.
  }
  Serial.println("Settle...");
  delay(1000);
}
void discharge()
{
  digitalWrite(FET_pin,HIGH);
  digitalWrite(FET_pin,LOW);
}
int16_t readADC()
{
  int16_t results = ads1015.readADC_Differential_VGND(1)*LSB_multiplier;
  Serial.println(results);
  return results;
}
const char helpText[] PROGMEM =
"\n"
"Available commands:" "\n"
"  ?     - shows available comands" "\n"
"  i     - take ECVin+ reading" "\n"
"  o     - take ECVout reading" "\n"
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





















