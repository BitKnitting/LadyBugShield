///
/// @mainpage	Ladybug_Shield_BLE_v0.1
///
/// @details	Firmware for Ladybug Shield
/// @n
/// @n
/// @n @a		Developed with [embedXcode+](http://embedXcode.weebly.com)
///
/// @author		Margaret Johnson
/// @author		Margaret Johnson
/// @date		4/15/15 4:24 PM
/// @version	<#version#>
///
/// @copyright	(c) Margaret Johnson, 2015
/// @copyright	License
///
/// @see		ReadMe.txt for references
///


///
/// @file		Ladybug_Shield_BLE_v0_1.ino
/// @brief		Main sketch
///
/// @details	<#details#>
/// @n @a		Developed with [embedXcode+](http://embedXcode.weebly.com)
///
/// @author		Margaret Johnson
/// @author		Margaret Johnson
/// @date		4/15/15 4:24 PM
/// @version	<#version#>
///
/// @copyright	(c) Margaret Johnson, 2015
/// @copyright	License
///
/// @see		ReadMe.txt for references
/// @n
///


// Core library for code-sense - IDE-based
#if defined(WIRING) // Wiring specific
#include "Wiring.h"
#elif defined(MAPLE_IDE) // Maple specific
#include "WProgram.h"
#elif defined(ROBOTIS) // Robotis specific
#include "libpandora_types.h"
#include "pandora.h"
#elif defined(MPIDE) // chipKIT specific
#include "WProgram.h"
#elif defined(DIGISPARK) // Digispark specific
#include "Arduino.h"
#elif defined(ENERGIA) // LaunchPad specific
#include "Energia.h"
#elif defined(LITTLEROBOTFRIENDS) // LittleRobotFriends specific
#include "LRF.h"
#elif defined(MICRODUINO) // Microduino specific
#include "Arduino.h"
#elif defined(TEENSYDUINO) // Teensy specific
#include "Arduino.h"
#elif defined(REDBEARLAB) // RedBearLab specific
#include "Arduino.h"
#elif defined(RFDUINO) // RFduino specific
#include "Arduino.h"
#elif defined(SPARK) // Spark specific
#include "application.h"
#elif defined(ARDUINO) // Arduino 1.0 and 1.5 specific
#include "Arduino.h"
#else // error
#error Platform not defined
#endif // end IDE

// Include application, user and local libraries
#include <HappyDay_Ladybug_pH.h>
#include <HappyDay_Ladybug_EC.h>
#include <Timer.h>
//For RBL BLE Shield
#include <SPI.h>
#include <boards.h>
#include <RBL_nRF8001.h>

// Prototypes
void read_pH_EC();

// Define variables and constants
//timers to read the pH and EC
//take a reading every minute.  It takes about 30 seconds to take an EC reading
//and about 10 seconds to take a pH reading
#define TIME_BETWEEN_READINGS 60000
Timer t_read_pH_EC;
//hold on to the values read for pH and EC
float pH_value = 0.;
float EC_value = 0.;
enum shield_states_T
{
    READING_PH,
    READING_EC,
    IDLE
}
state;
HappyDay_Ladybug_pH ladybug_pH;
HappyDay_Ladybug_EC ladybug_EC;
// Add setup code 
void setup() 
{
    state = IDLE;
    Serial.begin(9600);
    t_read_pH_EC.every(TIME_BETWEEN_READINGS,read_pH_EC);
}

// Add loop code 
void loop() 
{
    t_read_pH_EC.update();
}
/******************************************************************************
 * read the pH and EC values from the probes
 *******************************************************************************/
void read_pH_EC() {
    if (state == IDLE){
        state = READING_PH;
        pH_value = ladybug_pH.measure();
        state = READING_EC;
        EC_value = ladybug_EC.measure();
        state = IDLE;
    }
}