//
//  ViewController.swift
//  LBS_PH_UI_TEST1
//
//  Created by Margaret Johnson on 3/4/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BTDiscoveryDelegate {
    @IBOutlet weak var pH_value: UILabel!
    @IBOutlet weak var BLE_status: UILabel!
    @IBOutlet weak var BLE_RSSI: UILabel!
    @IBOutlet weak var EC_value: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btDiscovery.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func BLEDidUpdateState(state:String){
        BLE_status.text = state
    }
    func BLEDidUpdateRSSI(RSSI:NSNumber){
        BLE_RSSI.text = RSSI.stringValue
        println(BLE_RSSI.text)
    }
    func BLEDidUpdatepH(pH:String) {
        pH_value.text = pH
        println(pH_value.text)
    }
    func BLEDidUpdateEC(EC:String) {
        EC_value.text = EC
        println(EC_value.text)
    }

}

