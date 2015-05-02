//
//  LadybugShield.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/17/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//

import Foundation
import CoreBluetooth
// TODO: Stop using global vars
let kUserDefaultTypeKey = "Type"
let kUserDefaultStageKey = "Stage"
let kLadybugShieldPlantType:String = "Lettuce"
let kLadybugShieldPlantStage:String = "Seedling"
let plant_picker_data = [
    ["Lettuce","Tomato","Cucumber"],
    ["Seedling","Youth","Mature"]]

protocol LadybugShieldDelegate:class {
    func ladybugDidNotFindShield()
    func ladybugDidUpdateCurrent_pH(pH_current:String)
    func ladybugDidUpdateSetPoint_pH(pH_set_point:String)
    func ladybugDidUpdateCurrent_EC(EC_current:String)
    func ladybugDidUpdateSetPoint_EC(EC_set_point:String)
    func ladybugDidUpdateTypeAndStageRows(type_row:Int ,stage_row:Int)
    func ladybugDidConnectToShield()
}
class LadybugShield:NSObject,BTDiscoveryDelegate,BTServiceDelegate {
    let btDiscovery = BTDiscovery()
    let btService = BTService()
    var isConnected = false
    var discovery_timer = NSTimer()
    var peripheral_name = ""
    weak var delegate:LadybugShieldDelegate? = nil
    //what index (column 0 = plant types and column 1 = stages  for the type and stage strings within the plant_picker_data array
    func get_type_and_stage_rows(type:String, stage:String)-> (type:Int,stage:Int)? {
        let types = plant_picker_data[0]
        let stages = plant_picker_data[1]
        var type_found = false
        var stage_found = false
        var type_row = 0
        var stage_row = 0

        for (index,t) in enumerate(types){
            if t == type {
                type_row = index
                type_found = true
                for (i,s) in enumerate(stages){
                    if s == stage {
                        stage_row = i
                        stage_found = true
                        break
                    }
                }
            }
            if type_found && stage_found {
                return (type_row,stage_row)
            }
        }
        //couldn't find an index for the plant type and growth stage strings
        return nil
    }
    //the type string is found first column (= 0) of the plant_picker_data (2D) array
    //the stage string if dound in the second column
    func get_type_and_stage_strings(type_row:Int, stage_row:Int) -> (type_string:String,stage_string:String){
        let type_string = plant_picker_data [0][type_row]
        let stage_string = plant_picker_data[1][stage_row]
        return (type_string,stage_string)
    }
    func get_set_points(type:String,stage:String) -> (pH_set_point:Double,EC_set_point:UInt16)
    {
        var pH_set = 5.7
        var EC_set:UInt16 = 2000
        switch type {
            //lettuce
        case plant_picker_data[0][0]:
            switch stage {
                //seedling
            case plant_picker_data[1][0]:
                pH_set = 5.8
                EC_set = 2000
                //Youth
            case plant_picker_data[1][1]:
                pH_set = 5.8
                EC_set = 2000
                //mature
            case plant_picker_data[1][2]:
                pH_set = 5.8
                EC_set = 2000
            default:
                pH_set = 5.7
                EC_set = 2200
            }
            //tomato
        case plant_picker_data[0][1]:
            switch stage {
                //seedling
            case plant_picker_data[1][0]:
                pH_set = 6.5
                EC_set = 2400
                //Youth
            case plant_picker_data[1][1]:
                pH_set = 6.3
                EC_set = 3000
                //mature
            case plant_picker_data[1][2]:
                pH_set = 6.3
                EC_set = 3000
            default:
                pH_set = 6.3
                EC_set = 3000
            }
            //cucumber
        case plant_picker_data[0][2]:
            switch stage {
                //seedling
            case plant_picker_data[1][0]:
                pH_set = 5.7
                EC_set = 2200
                //Youth
            case plant_picker_data[1][1]:
                pH_set = 5.7
                EC_set = 2500
                //mature
            case plant_picker_data[1][2]:
                pH_set = 5.7
                EC_set = 2500
            default:
                pH_set = 6.3
                EC_set = 3000
            }
            
        default:
            pH_set = 5.7
            EC_set = 2000
        }
        return(pH_set,EC_set)
    }
    //save the shield settings onto the Arduino so that they are available accross reboots of the microcontroller.  
    //So far this includes set points, the plant type, and the plant's stage of growth.  
    //The plant type and growth stage have growing input (at some point)
    func update_shield(name:String,type:String,stage:String) {
        //the type of plant and growth stage must have pH and EC set point values
        //since a UIPicker was used...
        //save the user facing set point info (plant type and stage of growth)
        if isConnected {
            NSUserDefaults.standardUserDefaults().setObject(type, forKey: kUserDefaultTypeKey)
            NSUserDefaults.standardUserDefaults().setObject(stage, forKey: kUserDefaultStageKey)
            //given the plant type and growth stage, look up the set points for pH and EC
            var set_points = get_set_points(type,stage: stage)
            var rows = get_type_and_stage_rows(type,stage:stage)
            btService.update_shield(type,stage: stage)
        }
    }
    func get_pH_and_EC(name:String,timeout:NSTimeInterval) {
        isConnected = false
        peripheral_name = name
        btDiscovery.delegate = self
        btService.delegate = self
        btDiscovery.connect(peripheral_name)
        discovery_timer = NSTimer.scheduledTimerWithTimeInterval(timeout, target:self, selector: Selector("scan_timer_went_off"), userInfo: nil, repeats: true)
    }
    //ask the shield what it thinks the plant type and stage it is servicing
    func read_type_and_stage_strings() ->(plant_type:String,plant_stage:String)? {
        //TBD: Get from the shield.  This will require additional UI which is not necessary for the intial...or perhaps a shield should default..?
        let plant_type = kLadybugShieldPlantType
        let plant_stage = kLadybugShieldPlantStage
        return(plant_type,plant_stage)
    }
    // MARK: - Timer functions
    // BUMMER...did not find the shield within the amount allocated for discoverying it.
    func scan_timer_went_off() {
        discovery_timer.invalidate()
        isConnected = false
        if (delegate != nil) {
            delegate!.ladybugDidNotFindShield()
        }
    }
    //Find a Ladybug shield with the peripheral_name
    func BLEDidDiscover() {
        discovery_timer.invalidate()
        btDiscovery.connect(peripheral_name)
    }
    //now that there is a connection, we can read the pH and EC.
    func BLEDidConnect(peripheral:CBPeripheral!){
        println("--> connected to ladybug shield")
        isConnected = true
        if (delegate != nil) {
            delegate!.ladybugDidConnectToShield()
        }
        btService.peripheral = peripheral
        btService.getData()
        
    }
    func BLEDidUpdateReadings(pH_current_string:String,pH_set_point_string:String,EC_current_string:String, EC_set_point_string:String,plant_type_byte:Int,plant_stage_byte:Int)
    {
        if (delegate != nil) {
            delegate!.ladybugDidUpdateCurrent_pH(pH_current_string)
            delegate!.ladybugDidUpdateSetPoint_pH(pH_set_point_string)
            delegate!.ladybugDidUpdateSetPoint_EC(EC_set_point_string)
            delegate!.ladybugDidUpdateCurrent_EC(EC_current_string)
            //if the index values are out of range, don't tell the view controller
            //there is info on the plant type and growth stage - because received
            //bad data...
            if ( plant_type_byte > plant_picker_data[0].count-1  || plant_type_byte < 0){
                return;
            }
            if ( plant_stage_byte > plant_picker_data[1].count-1  || plant_stage_byte < 0){
                return;
            }
            delegate!.ladybugDidUpdateTypeAndStageRows(plant_type_byte, stage_row: plant_stage_byte)
        }
        
    }
    func start_pumping() {
        btService.start_pumping()
    }
    func stop_pumping() {
        btService.stop_pumping()
    }
}
