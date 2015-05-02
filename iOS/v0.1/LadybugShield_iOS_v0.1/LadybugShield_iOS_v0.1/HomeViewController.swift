//
//  HomeViewController.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/10/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//
//  UIPickerView Swift code tutorial: http://makeapppie.com/tag/uipickerview-in-swift/

import UIKit
import CoreBluetooth
let kLadybugShieldName:String = "Tommy"
var type:String!
var stage:String!

//shared between Home view controller and Setup View Controller
let ladybug = LadybugShield()

class HomeViewController: UIViewController,UIPickerViewDelegate,LadybugShieldDelegate {
    let device_name = kLadybugShieldName
    enum picker_component:Int {
        case plant_type=0
        case growth_stage=1
    }
    //setting pumping == true starts the app with the pumps off.
    var pumping = false
    @IBOutlet weak var UI_pump_button_object: UIButton!
    @IBAction func UI_pump_button(sender: UIButton) {
        pumping = !pumping
        if (!pumping){
            ladybug.stop_pumping()
            UI_pump_button_object.backgroundColor = UIColor.greenColor()
            UI_pump_button_object.setTitle("Start Pump", forState: UIControlState.Normal)
        }else {
            UI_pump_button_object.backgroundColor = UIColor.redColor()
            UI_pump_button_object.setTitle("Stop Pump", forState: UIControlState.Normal)
            ladybug.start_pumping()
        }
    }
    @IBOutlet weak var UI_plant_type: UILabel!
    @IBOutlet weak var UI_name: UILabel!
    @IBOutlet weak var UI_pH_current: UILabel!
    @IBOutlet weak var UI_pH_set_point: UILabel!
    @IBOutlet weak var UI_EC_current: UILabel!
    @IBOutlet weak var UI_EC_set_point: UILabel!
//    @IBOutlet weak var UI_ladybug_image: UIImageView!
    @IBOutlet weak var UI_stage_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI_pump_button_object.backgroundColor = UIColor.greenColor()
        ladybug.delegate = self
        ladybug.get_pH_and_EC(kLadybugShieldName, timeout:5)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewDidAppear(animated: Bool) {
//        if (ladybug.isConnected == false) && (UI_ladybug_image != nil){
//            UI_ladybug_image.center.x -= self.view.bounds.width
//            UI_ladybug_image.hidden = false
//            UIView.animateWithDuration(2, delay: 0.0,
//                options: .Repeat | .Autoreverse, animations: {
//                    self.UI_ladybug_image.center.x += self.view.bounds.width
//                }, completion: {if $0 { self.hide_ladybug() } })
//        }
//    }
    override func viewWillAppear(animated: Bool) {
        if ladybug.isConnected == false {
            UI_name.text = ".........."
            UI_plant_type.text = ".........."
//            UI_ladybug_image.image = UIImage(named:"Ladybug")
        } else {
            let set_points = ladybug.get_set_points(type,stage: stage)
            UI_EC_set_point.text = "\(set_points.EC_set_point)"
            UI_pH_set_point.text = "\(set_points.pH_set_point)"
            change_stage_image()
        }
    }
    func change_stage_image() {
        let name_of_image = type + "-" + stage
        println(name_of_image)
        UI_stage_image.image = UIImage(named:name_of_image)
    }
//    func hide_ladybug() {
//        UI_ladybug_image.hidden = true
//    }
    // MARK: LadybugShieldDelegate
    // handle the case where the shield with name "found_shield" was not found within the timeout period passed in earlier
    func ladybugDidNotFindShield(){
        println("---> LadybugDidNotFindShield")
    }
    func ladybugDidConnectToShield() {
        //set the name, type, and stage info so the grower knows what kind of plant type and stage will be/is growing 
        //in the nutrient bath.  First ask the shield what it thinks it is growing.  If the app can get the type and stage
        //from the shield, use that to set the plant info.  If not, use defaults.
        //Note: for now, type and stage are global String variables because they are used across classes.  A better mechanism would
        //probably be implementing a (datasource) protocol.  I'm still learning Swift.  Also, the names without knowing they are strings
        //is confusing because in other parts I use type and stage to represent ints.
        if let type_and_stage_strings = ladybug.read_type_and_stage_strings() {
            type = type_and_stage_strings.plant_type
            stage = type_and_stage_strings.plant_stage
            UI_plant_type.text = type
            change_stage_image()
          //the shield doesn't know what plant and stage it is supposed to be servicing.  Ideally, the app would have a nice way of asking the grower what they 
            //intend to grow.  For now, I'm defaulting.
        } else {
            
        }                //ask for plant type and stage of growth...but for now, default in read_type_and_stage.
        
        UI_plant_type.text = type
        change_stage_image()
// TODO: Grower chooses name.  Just using a default right now to simplify...
        UI_name.text = kLadybugShieldName
        // canceled by removing from superview
//        if (UI_ladybug_image != nil) {
//            UI_ladybug_image.hidden = true
//        }
    }
    func ladybugDidUpdateCurrent_pH(pH_current:String) {
        UI_pH_current.text = pH_current
    }
    func ladybugDidUpdateSetPoint_pH(pH_set_point:String) {
        UI_pH_set_point.text = pH_set_point
    }
    func ladybugDidUpdateCurrent_EC(EC_current: String) {
        UI_EC_current.text = EC_current
    }
    func ladybugDidUpdateSetPoint_EC(EC_set_point: String) {
        UI_EC_set_point.text = EC_set_point
    }
    //set the type and stage global String variables.  Also, set the UI fields
    //the represent the type and stage.
    func ladybugDidUpdateTypeAndStageRows(type_row: Int, stage_row: Int) {
        var plant_info = ladybug.get_type_and_stage_strings(type_row,stage_row: stage_row)
        type = plant_info.type_string
        UI_plant_type.text = type
        stage = plant_info.stage_string
        change_stage_image()
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
