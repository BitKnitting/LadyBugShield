//i2c Master Code(BEAN)
#include <Wire.h>

#define LADYBUG_I2C_ADDRESS    0x8
#define BEAN_I2C_ADDRESS       0x9
char pH_and_EC_str[20];

void setup()
{
  Serial.begin(9600);
  Wire.begin(BEAN_I2C_ADDRESS);        
  Wire.onReceive(receiveEvent);
}
void loop()
{
  //  //don't need pH values all the time so delay between advertising
  Bean.sleep(3000); 
}
void receiveEvent(int numBytesReceived)
{
  Serial.print("---> in receiveEvent.  numBytesReceived: ");
  Serial.println(numBytesReceived);
  if (numBytesReceived == 3) {
    uint8_t pH_value = Wire.read();
    uint8_t major = (pH_value >> 4);
    uint8_t minor = (pH_value &0x0F);
    utoa(major,pH_and_EC_str,10);
    strcat(pH_and_EC_str,".");
    char minor_str[2] = {
      minor +48,0                };
    strcat(pH_and_EC_str,minor_str);
    Serial.print("pH value: ");
    Serial.println(pH_and_EC_str);
    strcat(pH_and_EC_str,",");
    char buffer[10] = {
      0          };
    int16_t ec_value = (Wire.read() << 8) | Wire.read();
    utoa(ec_value,buffer,10);
    strcat(pH_and_EC_str,buffer);
    Serial.print("pH and EC: ");
    Serial.println(pH_and_EC_str);
    Bean.setBeanName(pH_and_EC_str);
  }
}












