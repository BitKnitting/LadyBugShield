//
//  BTDiscovery02072015.swift
//  Created by Margaret Johnson on 3/7/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//  Evolved from:
//  Created by Owen L Brown on 9/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//
import UIKit
import Foundation
import CoreBluetooth

let btDiscovery = BTDiscovery()
let BeanPeripheralUUID = CBUUID(string: "A495FF10-C5B1-4B44-B512-1370F02D74DE")
let RBL_SERVICE_UUID = CBUUID(string: "713D0000-503E-4C75-BA94-3148F18D941E")


protocol BTDiscoveryDelegate {
    func BLEDidUpdateState(state:String)
    func BLEDidUpdateRSSI(RSSI:NSNumber)
    func BLEDidUpdatepH(pH:String)
    func BLEDidUpdateEC(EC:String)
}
class BTDiscovery: NSObject, CBCentralManagerDelegate {
    
    let centralManager: CBCentralManager!
    var delegate:BTDiscoveryDelegate? = nil
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    // MARK:CBCentralManagerDelegate Callbacks
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        var state_string = "Unknown"
        switch central.state {
        case CBCentralManagerState.PoweredOff:
            state_string = "Powered Off"
            break
            
        case CBCentralManagerState.Unauthorized:
            // Indicate to user that the iOS device does not support BLE.
            state_string = "Unauthorized"
            break
            
        case CBCentralManagerState.Unknown:
            // Wait for another event
            break
            
        case CBCentralManagerState.PoweredOn:
            state_string = "Powered On"
            self.startScanning()
            break;
            
        case CBCentralManagerState.Resetting:
            state_string = "Resetting"
            break
            
        case CBCentralManagerState.Unsupported:
            state_string = "Unsupported"
            break
            
        default:
            break
        }
        if (delegate != nil){
            delegate!.BLEDidUpdateState(state_string)
        }
    }
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Peripheral found: \(peripheral)");
        printDetails(advertisementData)
        if (delegate != nil){
            delegate!.BLEDidUpdateRSSI(RSSI)
            //This is a kind of hokey way of doing this...basically use the name to send over pH and EC. I'm doing this just for proof of concept.  Eventually it would
            //be within the advertisement data and not the name...
            let pH_and_EC_value = advertisementData[CBAdvertisementDataLocalNameKey] as String
            println(pH_and_EC_value)
            let pH_and_EC_array = split(pH_and_EC_value,{$0==","},allowEmptySlices:false)
            if (pH_and_EC_array.count == 2)
            {
                let pH_value = pH_and_EC_array[0]
                let EC_value = pH_and_EC_array[1]
                println("updating pH value")
                delegate!.BLEDidUpdatepH(pH_value)
                println("updating EC value")
                delegate!.BLEDidUpdateEC(EC_value)
            }
        }
        // Validate peripheral information
        if peripheral == nil  {
            return
        }
    }
    // MARK: - Functions
    func startScanning() {
        println("Stop scan")
        centralManager?.stopScan()
        println("start scan")
        let optionDictionary = [CBCentralManagerScanOptionAllowDuplicatesKey:true]
        if let central = centralManager {
            central.scanForPeripheralsWithServices([RBL_SERVICE_UUID], options: optionDictionary)
        }
    }
    func stopScanning() {
        println("Stop scan")
        centralManager?.stopScan()
    }
    func printDetails(advertisementData: [NSObject : AnyObject]!) {
        for (myKey,myValue) in advertisementData {
            println("key: \(myKey) value: \(myValue) ")
        }
    }
}
