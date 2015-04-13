//
//  HomeViewController.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/10/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//
//  UIPickerView Swift code tutorial: http://makeapppie.com/tag/uipickerview-in-swift/

import UIKit

class HomeViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    let plant_picker_data = [
    ["Leafy","Tomato","Cucumber"],
        ["Seedling","Youth","Mature"]
    ]
    enum picker_component:Int {
        case plant_type=0
        case growth_stage=1
    }
    @IBOutlet weak var UI_plant_picker: UIPickerView!
    @IBOutlet weak var UI_RSSI: UILabel!
    @IBOutlet weak var UI_name: UILabel!
    @IBOutlet weak var UI_pH_current: UILabel!
    @IBOutlet weak var UI_pH_set_point: UILabel!
    @IBOutlet weak var UI_EC_current: UILabel!
    @IBOutlet weak var UI_EC_set_point: UILabel!
    @IBAction func UI_update() {
    }
    @IBAction func UI_on_off_pump_switch(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UI_plant_picker.delegate = self
        UI_plant_picker.dataSource = self
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK -Delgates and DataSource
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        updateLabel()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return plant_picker_data.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plant_picker_data[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return plant_picker_data[component][row]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
