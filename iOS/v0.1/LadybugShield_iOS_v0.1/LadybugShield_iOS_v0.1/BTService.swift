//
//  BTService.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/17/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreData
import UIKit
protocol BTServiceDelegate:class {
    func BLEDidUpdateReadings(pH_curent_string:String,pH_set_point_string:String,EC_current_string:String, EC_set_point_string:String,plant_type_byte:Int, plant_stage_byte:Int,pump_state_byte:UInt8)
    //not tested enough!
    func BLEDidGetPumpState(pump_state:UInt8)
}
let RBL_CHAR_RX__UUID = CBUUID(string: "713D0003-503E-4C75-BA94-3148F18D941E")
let RBL_CHAR_TX__UUID = CBUUID(string: "713D0002-503E-4C75-BA94-3148F18D941E")
class BTService: NSObject,CBPeripheralDelegate{
    var peripheral: CBPeripheral!
    weak var delegate:BTServiceDelegate? = nil
    var characteristic_send_data = CBCharacteristic()
    override init() {
        super.init()
    }
    //send the set up info (set points, plant type and stage) to the shield.  The shield maintains this info across reboots.  This info is key to adjusting 
    //the pH and nutrients.
    //look up info for type/stage set points is done using the string representations.  E.g.: type might be "Tomato"  and stage might be "Youth"
    func update_shield(type:String,stage:String) {
        //make sure the peripheral/characteristic is connected (available)
        if (peripheral.state != .Connected){
            println("Peripheral is not connected. Did not update set points")
            return
        }
        //write set points to the Ladybug Shield (the peripheral)
        //for now, the set point won't be less than zero...so set the next byte to anything but '-'
        var data = NSMutableData()
        //COMMAND CODE
        var uint_8:UInt8 = 97  //command code = 'a'
        data.appendBytes(&uint_8,length: 1)
        //SIGN (setting to positive with 0)
        uint_8 = 0
        data.appendBytes(&uint_8,length:1)
        let set_points = ladybug.get_set_points(type, stage: stage)
        //pH SET POINT
        uint_8 = pack_pH(set_points.pH_set_point)
        data.appendBytes(&uint_8,length:1)
        //EC SET POINT
        var uint_16:UInt16 = pack_EC(set_points.EC_set_point)
        data.appendBytes(&uint_16,length:2)
        //the grower might have gone to set up and changed the plant type and/or stage.  Currently I am using a UIPickerView so I go between an array of strings that holds the
        //type and stage names to the index of the type or stage in the array of strings.  The index is sent to the shield.
        if let rows = ladybug.get_type_and_stage_rows(type, stage: stage) {
            //plant_picker_data ROW FOR CURRENT PLANT TYPE
            uint_8 = UInt8(rows.type)
            data.appendBytes(&uint_8,length:1)
            //plant_picker data ROW FOR CURRENT PLANT STAGE
            uint_8 = UInt8(rows.stage)
            data.appendBytes(&uint_8,length:1)
        }
            //couldn't find a row for the plant type and growth stage
        else {
            uint_8 = 0
            data.appendBytes(&uint_8,length:1)
            uint_8 = 0
            data.appendBytes(&uint_8,length:1)
        }
//        var array_of_bytes = [UInt8](count:5,repeatedValue:0)
//        data.getBytes(&array_of_bytes,length:5);
//        println("Bytes to send: \(array_of_bytes)")
        peripheral.writeValue(data, forCharacteristic: characteristic_send_data, type: CBCharacteristicWriteType.WithoutResponse)
    }
    func getData() {
        peripheral.delegate = self
        peripheral.discoverServices([RBL_SERVICE_UUID])
    }
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        
        if let actualError = error{
            println("---> Error in didDiscoverServices... \(error)")
        }
        else {
            for service in peripheral.services as! [CBService]!{
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        }
    }
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        
        if let actualError = error{
            
        }
        else {
            
            if service.UUID == RBL_SERVICE_UUID{
                for characteristic in service.characteristics as! [CBCharacteristic]{
                    switch characteristic.UUID{
                        
                    case RBL_CHAR_RX__UUID:
                        println("RBL_CHAR_RX_UUID: TBD")
                        characteristic_send_data = characteristic
                    case RBL_CHAR_TX__UUID:
                        println("--> waiting for data from Ladybug Shield")
                        peripheral.setNotifyValue(true,forCharacteristic:characteristic)
                    default:
                        println()
                    }
                    
                }
            }
        }
    }
    //a reading came in from the Ladybug Shield...Current all data is bundled
    //into one reading.  The bytes that are read are documented within the Arduino sketch.
    func update(ladybug_shield_data:NSData){
        //make a first check that the amount of bytes received isn't zany
        if (ladybug_shield_data.length > 100) {
            println("Received at least 100 bytes of data..expected to receive much less")
            return;
        }
        //check which record type
        //Note: for now, pump state and set points are in record 1.  Not using record 2.
        // record type 1: a measurement
        // record type 2: the pump state
        var buffer = [UInt8](count: ladybug_shield_data.length, repeatedValue: 0x00)
        ladybug_shield_data.getBytes(&buffer, length: buffer.count)
        //the version is the first byte
        let version = buffer[0]
        if (version == 1){
            //check to make sure the correct number of bytes is returned
            if (ladybug_shield_data.length != 14){
                //TBD: notify caller or bcast or add as error...
                println("expected a data length of 14.  Received \(ladybug_shield_data.length) bytes")
                return;
            }
            
            println("\(ladybug_shield_data.length) bytes of data arrived (pH and EC readings)")
            //the next byte is the current value of the pH read by the shield
            let pH_current_string =  unpack_pH(buffer[1])
            //one byte for the set point
            let pH_set_point_string = unpack_pH(buffer[2])
            //and then two bytes for the current EC value
            let EC_current_string = unpack_uint16(buffer[3],lsb: buffer[4])
            //followed by two bytes for the EC Set point
            let EC_set_point_string = unpack_uint16(buffer[5],lsb: buffer[6])
            //then one byte for the type
            let plant_type_byte = Int(buffer[7])
            //and another byte for the stage
            let plant_stage_byte = Int(buffer[8])
            //get the amount of ms pH dose pumped since last measurement
            let pH_pump_time = UInt16(buffer[9]) << 8 | UInt16(buffer[10])
            //get the amount of ms EC dose pumped since last measurement
            //        let EC_pump_time = unpack_uint16(buffer[11], lsb: buffer[12])
            let EC_pump_time = UInt16(buffer[11]) << 8 | UInt16(buffer[12])
            //get the pump state
            let pump_state_byte = buffer[13]
            //put a record into the database
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            let entity = NSEntityDescription.entityForName("Measurement",inManagedObjectContext:managedContext)
            let measurement = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
            measurement.setValue(pH_set_point_string, forKey: "pH_SetPoint")
            measurement.setValue(pH_current_string, forKey: "pH_Current")
            measurement.setValue(EC_set_point_string, forKey: "eC_SetPoint")
            measurement.setValue(EC_current_string, forKey: "eC_Current")
            var castAsNSNumber : NSNumber = NSNumber(unsignedShort: pH_pump_time)
            measurement.setValue(castAsNSNumber, forKey: "pH_pumpTime")
            castAsNSNumber  = NSNumber(unsignedShort: EC_pump_time)
            measurement.setValue(castAsNSNumber, forKey: "eC_pumpTime")
            let date = NSDate()
            measurement.setValue(date, forKey:"date")
            //persist
            var error: NSError?
            if !(managedContext.save(&error)){
                println("Whoops, couldn't save.  Error: \(error?.localizedDescription)")
            }
            if (delegate != nil){
                delegate!.BLEDidUpdateReadings(pH_current_string,pH_set_point_string: pH_set_point_string,EC_current_string:EC_current_string, EC_set_point_string:EC_set_point_string,plant_type_byte:plant_type_byte,plant_stage_byte:plant_stage_byte,pump_state_byte:pump_state_byte)
            }
        }else if (version == 2){ // the next byte contains the state of pumping
            let pump_state = buffer[1]
            if (delegate != nil){
                delegate!.BLEDidGetPumpState(pump_state)
            }
        }
    }
    //callback if used the peripheral.setNotifyValue or readValue
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        
        if let actualError = error{
            
        }else {
            switch characteristic.UUID{
            case RBL_CHAR_TX__UUID:
                update(characteristic.value)
                
            default:
                println()
            }
        }
    }
    //MARK: Helper functions
    func unpack_pH(pH: UInt8) -> String
    {
        let major = String(pH >> 4)
        let minor = String(pH & 15)
        let pH_str = major+"."+minor
        return pH_str
    }
    func unpack_uint16(msb:UInt8,lsb:UInt8) -> String
    {
        let value = UInt16(msb) << 8 | UInt16(lsb)
        let EC_str = "\(value)"
        return EC_str
    }
//caller knows if the pH is negative.  Most of the time it won't be since negative pH's are more basic.
func pack_pH(pH:Double)->UInt8
{
    var major = UInt8(pH)
    var minor:UInt8 = 0
    //break up the major and minor part of the pH value and accommodate for a precision of .1 (e.g.: 4.5 vs. 4.46)
    var temp = pH + 0.051 - Double(major)
    if (temp >= 1.0) {
        major += 1
    }
    else {
        minor = UInt8(temp * 10.0)
    }
    //pack the major and minor values into a byte and then put it on the loading dock
    let value = major << 4 | minor
    return value
}
func pack_EC(EC_value:UInt16) -> UInt16
{
    println("--> EC value: \(EC_value)")
    var packed_EC = EC_value.byteSwapped
    return packed_EC
}
    /******************************************************************************
    * get_pump_state
    * the shield/arduino stores whether previously the app had told it to maintain/start pumping
    * or stop pumping.  When the UI comes up, set the Start/Stop pump button to match
    * what the shield/Arduino has
    *******************************************************************************/
    func get_pump_state() {
        if  (peripheral == nil || peripheral?.state != .Connected){
            println("Peripheral is not connected. Did not get pump state")
            return
        } 
        //tell the shield to start pumping if either the pH or EC is not within the
        //range of its set point
        var data = NSMutableData()
        //COMMAND CODE
        var uint_8:UInt8 = 100  //command code = 'd'
        data.appendBytes(&uint_8,length: 1)
        peripheral.writeValue(data, forCharacteristic: characteristic_send_data, type: CBCharacteristicWriteType.WithoutResponse)
    }
func start_pumping() {
    //make sure the peripheral/characteristic is connected (available)
    if (peripheral.state != .Connected){
        println("Peripheral is not connected. Did not update set points")
        return
    }
    //tell the shield to start pumping if either the pH or EC is not within the
    //range of its set point
    var data = NSMutableData()
    //COMMAND CODE
    var uint_8:UInt8 = 98  //command code = 'b'
    data.appendBytes(&uint_8,length: 1)
    peripheral.writeValue(data, forCharacteristic: characteristic_send_data, type: CBCharacteristicWriteType.WithoutResponse)
    }
    func stop_pumping() {
        //make sure the peripheral/characteristic is connected (available)
        if (peripheral.state != .Connected){
            println("Peripheral is not connected. Did not update set points")
            return
        }
        //tell the shield to start pumping if either the pH or EC is not within the
        //range of its set point
        var data = NSMutableData()
        //COMMAND CODE
        var uint_8:UInt8 = 99  //command code = 'c'
        data.appendBytes(&uint_8,length: 1)
        peripheral.writeValue(data, forCharacteristic: characteristic_send_data, type: CBCharacteristicWriteType.WithoutResponse)

    }
}