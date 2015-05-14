///
/// @file		HappyDay_Ladybug_pH.h
/// @brief		Class library header
/// @details	Measures the pH of a bath of liquid using the Ladybug Shield
/// @n
/// @n @b		Project
///
/// @author		Margaret Johnson
/// @author		HappyDay Ladybug pH
///
/// @date		3/30/15 12:56 PM
/// @version	1.0
///
/// @copyright	(c) Margaret Johnson, 2015
/// @copyright	<#license#>
///
///


#include "Arduino.h"


#ifndef HappyDay_Ladybug_ph_h

#define HappyDay_Ladybug_ph_h

#define Write_Check      0x1234
struct parameters_T
{
    unsigned int WriteCheck;
    int16_t pH7Cal, pH4Cal;
    float pHStep;
};
///
/// @class	<#Description#>
///
class HappyDay_Ladybug_pH {
protected:
    parameters_T params;
public:
    HappyDay_Ladybug_pH();
    float measure(void);
    void calibrate(byte pH_to_calibrate);
    void readParams(int16_t *pH4Cal, int16_t *pH7Cal,float *pHStep);
private:

    void resetParams(void);
    int ideal_pH7_mV(void);
    int ideal_pH4_mV(void);
    float calcpH(int adc_value_read);
    void update_calibration_params (byte pH_to_calibrate, int pH_mV);
    int16_t readADC(byte pH_or_EC);
    bool param_values_ok(void);
};

#endif
