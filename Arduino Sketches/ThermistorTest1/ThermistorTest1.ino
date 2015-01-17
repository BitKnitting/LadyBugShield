
#include <Time.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>
// resistance at 25 degrees C
#define THERMISTORNOMINAL 10000      
// temp. for nominal resistance (almost always 25 C)
#define TEMPERATURENOMINAL 25   
// The beta coefficient of the thermistor (usually 3000-4000)
#define BCOEFFICIENT 3977

float VClean=5060;

Adafruit_ADS1015 ads1015;

void setup(void)
{
  Serial.begin(9600);
  Serial.println("Start!");
  Serial.println("Reading Thermistor ADC Range: +/- 4.096V (1 bit = 2mV)");
  ads1015.begin();
  ads1015.setGain(GAIN_ONE);
//  VClean = readVcc();
}

void loop(void)
{
  float V0 = ads1015.readADC_SingleEnded(2);
  V0 = V0*2;
  printTime();
  Serial.print(" | ");
  float rTherm = 10000.*(VClean/V0 - 1.);
  Serial.print("ADC reading: ");
  Serial.print(V0);
  Serial.print("mV | Thermistor reading: " );
  Serial.print(rTherm);
  Serial.print(" ohms");
  float steinhartTemp;
  steinhartTemp = rTherm / THERMISTORNOMINAL;     // (R/Ro)
  steinhartTemp = log(steinhartTemp);                  // ln(R/Ro)
  steinhartTemp /= BCOEFFICIENT;                   // 1/B * ln(R/Ro)
  steinhartTemp += 1.0 / (TEMPERATURENOMINAL + 273.15); // + (1/To)
  steinhartTemp = 1.0 / steinhartTemp;                 // Invert
  steinhartTemp -= 273.15; 
  Serial.print(" | Temperature "); 
  Serial.print(steinhartTemp);
  Serial.print(" *C | ");
  steinhartTemp = (steinhartTemp * 9.0)/ 5.0 + 32.0;
  Serial.print(steinhartTemp);
  Serial.println(" *F");

  delay(1000);

}
void printTime(){
  // digital clock display of the time
  Serial.print(hour());
  printDigits(minute());
  printDigits(second());

}
void printDigits(int digits){
  // utility function for digital clock display: prints preceding colon and leading 0
  Serial.print(":");
  if(digits < 10)
    Serial.print('0');
  Serial.print(digits);
}

