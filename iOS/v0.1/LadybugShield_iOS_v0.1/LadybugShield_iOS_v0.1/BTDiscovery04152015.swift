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
    let RBL_SERVICE_UUID = CBUUID(string: "713D0000-503E-4C75-BA94-3148F18D941E")
protocol BTDiscoveryDelegate:class {
    func BLEDidDiscover()
     func BLEDidConnect(connecting_peripheral:CBPeripheral!)
}
class BTDiscovery: NSObject, CBCentralManagerDelegate,CBPeripheralDelegate {

    private var centralManager = CBCentralManager()
    private var peripheral_name = ""
    var connecting_peripheral:CBPeripheral!
    weak var delegate:BTDiscoveryDelegate! = nil
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    // MARK: Functions on class
    func connect(name:String){
        peripheral_name = name
        println("---> connect to peripheral named \(peripheral_name)")
        //scanning starts in centralManagerDidUpdateState
        //then subsequent call backs end up (if successful) in DidConnectPeripheral
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
        println("BT state: " + state_string)
        if (delegate != nil){
//            delegate!.BLEDidUpdateState(state_string)
        }
    }
    // TODO: Choose between Ladybug Shields
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Peripheral found: \(peripheral)");
        if (peripheral == nil) {
        return;
        }
        printDetails(advertisementData)
        let name_of_this_peripheral  = advertisementData [CBAdvertisementDataLocalNameKey] as! String
        //is the name of the device the one the instance is looking for?
        if (peripheral_name == name_of_this_peripheral) {
            if (delegate != nil){
                delegate!.BLEDidDiscover()
            }
            println("found the shield.  Connecting...")
            //connect to the peripheral (should get a didConnectPeripheral callback)
            connecting_peripheral = peripheral
            connecting_peripheral.delegate = self;
            centralManager.connectPeripheral(connecting_peripheral,options:nil)
            //We can stop scanning because we found what we were looking for
            stopScanning()
        }
    }
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        if (peripheral == nil) {
            return;
        }
        // Connect to the Ladybug shield and call back the Ladybug shield class
        if (connecting_peripheral == peripheral) {
            if (delegate != nil){
                delegate!.BLEDidConnect(connecting_peripheral)
            }
        }
    }
    // MARK: - Functions
    func startScanning() {
        println("Stop scan")
        centralManager.stopScan()
        println("start scan")
        //Find Ladybug Shields which are using the Red Bear Lab BLE Shield
        let optionDictionary = [CBCentralManagerScanOptionAllowDuplicatesKey:true]
        let central = centralManager
            central.scanForPeripheralsWithServices([RBL_SERVICE_UUID], options: optionDictionary)
    }
    func stopScanning() {
        println("Stop scan")
        centralManager.stopScan()
    }
    func printDetails(advertisementData: [NSObject : AnyObject]!) {
        for (myKey,myValue) in advertisementData {
            println("key: \(myKey) value: \(myValue) ")
        }
    }
}
