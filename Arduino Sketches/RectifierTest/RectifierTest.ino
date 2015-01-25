
#include <Time.h>
#include <Wire.h>
#include <Adafruit_ADS1015.h>

Adafruit_ADS1015 ads1015;
const byte gate_pin = 8;

void setup(void)
{
  Serial.begin(9600);
  pinMode(gate_pin,OUTPUT);
  Serial.println("Start!");
  ads1015.begin();
  //  ads1015.setGain(GAIN_FOUR);
  //  ads1015.setGain(GAIN_ONE);
}

void loop(void)
{
  //  Serial.println("top of loop");
  int16_t results=0;
  digitalWrite(gate_pin,HIGH); //Discharge the capacitor
  digitalWrite(gate_pin,LOW);  //Open the short circuit
  results = ads1015.readADC_Differential_VGND(0);

  Serial.println(results*3);
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

