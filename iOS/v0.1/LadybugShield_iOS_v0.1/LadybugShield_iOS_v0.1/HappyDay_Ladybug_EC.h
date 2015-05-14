///
/// @file		HappyDay_Ladybug_EC.h
/// @brief		Class library header
/// @details	Measures the EC of a bath of liquid using the Ladybug Shield
/// @n
/// @n @b		Project
///
/// @author		Margaret Johnson
/// @author		HappyDay Ladybug pH
///
/// @date		3/31/15
/// @version	1.0
///
/// @copyright	(c) Margaret Johnson, 2015
/// @copyright	<#license#>
///
///


#include "Arduino.h"
#include <Statistic.h>
#include <Adafruit_ADS1015.h>

#ifndef HappyDay_Ladybug_EC_h

#define HappyDay_Ladybug_EC_h


///
/// @class	<#Description#>
///
class HappyDay_Ladybug_EC {
protected:
    Statistic myStats;
    Adafruit_ADS1015 ads1015;
public:
    HappyDay_Ladybug_EC();
    uint16_t measure(void);
private:
    int readEC(byte signal);
    void switchTo(byte signal);
    uint16_t calcEC();
    int16_t readADC(byte pH_or_EC);
};

#endif
