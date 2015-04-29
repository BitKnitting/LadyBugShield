//
//  SetupViewController.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/24/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var UI_plant_picker: UIPickerView!
    @IBAction func UI_update_plant_picker(sender: UIButton) {
        updatePlantPicker()
    }
    
    func updatePlantPicker()
    {
        if ladybug.isConnected {
            type = plant_picker_data[0][UI_plant_picker.selectedRowInComponent(0)]
            stage = plant_picker_data[1][UI_plant_picker.selectedRowInComponent(1)]
            NSUserDefaults.standardUserDefaults().setObject(type, forKey: kUserDefaultTypeKey)
            NSUserDefaults.standardUserDefaults().setObject(stage, forKey: kUserDefaultStageKey)
            ladybug.update_shield(kLadybugShieldName,type: type,stage: stage)
        }
    }
    func set_plant_picker() {
        //get the last stored strings for the plant type and growth stage
        let defaults = NSUserDefaults.standardUserDefaults()
        //just in case this is the first time the app has launched
        let registration_dictionary = [kUserDefaultTypeKey:kLadybugShieldPlantType,kUserDefaultStageKey:kLadybugShieldPlantStage]
        defaults.registerDefaults(registration_dictionary)
        //don't check for nil because set defaults
        type = defaults.stringForKey(kUserDefaultTypeKey)
        stage = defaults.stringForKey(kUserDefaultStageKey)
        //find out which row and component within UIPicker the plant type and growth are represented
        if let rows = ladybug.get_type_and_stage_rows(type,stage:stage) {
            //the list of plants is the first spinner.  the list of plant stages is
            //the second spinner.
            UI_plant_picker.selectRow(rows.type, inComponent: 0, animated: false)
            UI_plant_picker.selectRow(rows.stage, inComponent: 1, animated: false)
        }
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UI_plant_picker.delegate = self
        UI_plant_picker.dataSource = self
        set_plant_picker()
    }
    //MARK: PickerView Delgates and DataSource
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
        }
        var string_in_plant_picker:String = plant_picker_data[component][row]
        //the font used by default was larger than the body's font.  It didn't look good.
        let attributed_string = NSAttributedString(string: string_in_plant_picker, attributes: [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
        pickerLabel!.attributedText = attributed_string
        return pickerLabel
    }
}
