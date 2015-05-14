//
//  SetupViewController.swift
//  LadybugShield_iOS_v0.1
//
//  Created by Margaret Johnson on 4/24/15.
//  Copyright (c) 2015 Margaret Johnson. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class SetupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var UI_plant_picker: UIPickerView!
    @IBAction func UI_update_plant_picker(sender: UIButton) {
        updatePlantPicker()
    }
    
    @IBAction func UI_Export_Log(sender: UIButton) {
        //access log data in Core Data and create a CSV file
        if let csv_log_file_path = create_CSV_from_log_data() {
            //send CSV file as an email attachment
            email_CSV_file(csv_log_file_path)
        }
    }
    @IBAction func UI_Clear_Log() {
        delete_all_entities_from_log_database();
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
    func create_CSV_from_log_data() -> String?{
        let measure_file_path = NSTemporaryDirectory() + "Measurements.csv"
        //get an instance of the records
        if var measurement_file = NSOutputStream(toFileAtPath: measure_file_path, append: true) {
            measurement_file.open()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            let fetchRequest = NSFetchRequest(entityName:"Measurement")
            var error: NSError?
                        var write_to_file_error: NSError? = nil
                        var csv_string:String = ""
            if let results = managedContext.executeFetchRequest(fetchRequest,
                error: &error) as? [NSManagedObject]
            {
                //******************************************************
                //got an instance to the measurement data now...
                //open a file to write CSV formatted rows into.
                //            let exportFileURL = NSURL(fileURLWithPath: exportFilePath)!
                NSFileManager.defaultManager().createFileAtPath(measure_file_path, contents: NSData(), attributes: nil)
                
                //            if let fileHandle = NSFileHandle(forWritingToURL: exportFileURL, error: &fileHandleError){
                //****************************************************
                //the file is now ready to be written to...
                //get the attributes of each entry
                //put the attributes into a CSV string:
                // Day, Time, pH current, pH set point,pH pump time, EC current, EC set point, EC pump time
                //write the CSV string into the file
                //keep doing this until all records in the database are written to the file
                println("Number of records in measurement: \(results.count)")


                for measurement in results {
                    //create the CSV string
                    let pH_set_point_string = measurement.valueForKey("pH_SetPoint") as? String
                    let pH_current_string = measurement.valueForKey("pH_Current") as? String
                    let EC_set_point_string = measurement.valueForKey("eC_SetPoint") as? String
                    let EC_current_string = measurement.valueForKey("eC_Current") as? String
                    let pH_pump_time_NSNumber = measurement.valueForKey("pH_pumpTime") as? NSNumber
                    let EC_pump_time_NSNumber = measurement.valueForKey("EC_pumpTime") as? NSNumber
                    let date = measurement.valueForKey("date") as? NSDate
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = .ShortStyle
                    let date_string = dateFormatter.stringFromDate(date!)
                    dateFormatter.dateStyle = .NoStyle
                    dateFormatter.timeStyle = .ShortStyle
                    let time_string = dateFormatter.stringFromDate(date!)
                    let pH_pump_time_string = pH_pump_time_NSNumber?.stringValue
                    let EC_pump_time_string = EC_pump_time_NSNumber?.stringValue
                    //TODO: I don't have a good grasp on reading/writing to a file
                    //this works for prototype
                    let csv_string = "\(date_string),"+"\(time_string),"+"\(pH_current_string!),"+"\(pH_set_point_string!),"+"\(pH_pump_time_string!),"+"\(EC_current_string!)," +
                        "\(EC_set_point_string!),"+"\(EC_pump_time_string!)\n"
                    //put CSV string into file
                   measurement_file = NSOutputStream(toFileAtPath: measure_file_path, append: true)!
                    measurement_file.open()
                    measurement_file.write(csv_string,maxLength:csv_string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))
                    measurement_file.close()
                    //create the CSV string
                    println("CSV: \(csv_string)  length:\(csv_string.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))")
                    var fileData = NSData(contentsOfFile: measure_file_path)
                     println("file size: \(fileData!.length)")
                }
                if var fileData = NSData(contentsOfFile: measure_file_path) {
                    println("file size: \(fileData.length)")
                }
            }else {
                println("Could not fetch \(error), \(error!.userInfo)")
                return nil
            }
        } else {
            println("Could not get a file ")
            return nil
        }
        //put CSV string in file
//        let wrote_to_file = csv_string.writeToFile(measure_file_path, atomically: true, encoding: NSASCIIStringEncoding, error: &write_to_file_error)
//        if (!wrote_to_file){
//            println("Did not write to file.  Error: \(write_to_file_error?.localizedDescription)")
//            return nil
//        }
        return measure_file_path
    }
    func email_CSV_file(file_path: String){
        //Check to see the device can send email.
        
        if( MFMailComposeViewController.canSendMail() ) {
            println("Can send email.")
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            mailComposer.setSubject("Measurements")
            mailComposer.setMessageBody("Measurement data.", isHTML: false)
            if let fileData = NSData(contentsOfFile: file_path) {
                println("File data loaded. Length: \(fileData.length)")
                mailComposer.addAttachmentData(fileData, mimeType: "text/csv", fileName: "measurements.csv")
                mailComposer.setToRecipients(["happyday.mjohnson@gmail.com"])
                //delete the file
                if let file = NSFileHandle(forUpdatingAtPath: file_path) {
                    file.truncateFileAtOffset(0)
                    file.closeFile()
                }
            }
            self.presentViewController(mailComposer, animated: true, completion: nil)
        }
    }

    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func print_status(measurement_file:NSStream){
        print("Status: ")
        switch (measurement_file.streamStatus) {
        case .NotOpen:
            println("Not open")
        case .Opening:
            println("Opening")
        case .Open:
            println("Open")
        case .Reading:
            println("Reading")
        case .Writing:
            println("Writing")
        case .AtEnd:
            println("At End")
        case .Closed:
            println("Closed")
        case .Error:
            println("Error")
        default:
            println("Unknown")
        }
    }
    func delete_all_entities_from_log_database() {
        //fetch (request) all entities
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Measurement")
        //only need the managedObject's ID to delete an entity
        fetchRequest.includesPropertyValues = false
        //delete all entities
        var error: NSError?
        if let results = managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject] {
                for measurement in results {
                    managedContext.deleteObject(measurement)
                }
        }else {
             println("Whoops, couldn't delete entities from database.  Error: \(error?.localizedDescription)")
        }
        
    }

}
