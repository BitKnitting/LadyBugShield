
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
#define pump_pin 7
  unsigned long t=0;
void setup()
{
  Serial.begin(9600);
  pinMode(pump_pin,OUTPUT);
  showHelp();
}
void loop()
{
  serialHandler();
}
void serialHandler()
{
  char inChar;

  if((inChar = Serial.read())>0) {
    DEBUG_PRINTF("Character read: ");
    DEBUG_PRINTLN(inChar);
    switch (inChar) {
    case 't':
    case 'T': 
      {
        t = getTime(); 
      }
      break;
    case 'p':
    case 'P': 
      {
        pump(t);
      }
      break;
    case '?':
      showHelp();
      break;
    default:
      break;
    }
    showHelp();
  }
}
unsigned long getTime()
{
  Serial.print("\r\nEnter number of millis to pump ");
  while (Serial.available()==0);
  unsigned long t_in_ms = Serial.parseInt();
  return t_in_ms;
}
void pump(unsigned long time_in_ms)
{
  DEBUG_PRINTF("Turning pump on for ");
  DEBUG_PRINT(time_in_ms);
  DEBUG_PRINTLNF("mS");
  digitalWrite(pump_pin,HIGH);
  delay(time_in_ms);
  digitalWrite(pump_pin,LOW);
}
const char helpText[] PROGMEM =
"\n"
"Available commands:" "\n"
"  ?     - shows available comands" "\n"
"  t     - enter number of mS to pump" "\n"
"  p     - pump" "\n"
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




