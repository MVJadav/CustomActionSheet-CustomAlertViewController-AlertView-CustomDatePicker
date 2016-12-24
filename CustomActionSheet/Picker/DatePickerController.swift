//
//  DatePickerController.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

//MARK: Date Format
struct DateFormat{
    static let MMMM_dd_yyyy : String                = "MMMM dd yyyy"
    static let MMMM_dd_yyyy_hh_mm : String          = "MMMM dd yyyy hh:mm"
    static let MM_dd_yyyy : String                  = "MM/dd/yyyy"
    static let MM_dd_yyyy_HH_mm : String            = "MM-dd-yyyy HH:mm"
    static let yyyy_MM_dd_T_HH_mm_ssZ : String      = "yyyy-MM-dd'T'HH:mm:ssZ"
}

class DatePickerController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Aoutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var dateWithTime : Bool     = false
    var dateFormatter           = DateFormatter()
    var datePickerCompletion: ((_ pickedDate:String) -> ())!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.datePickerViewBottomConstraint.constant = -380
        if(dateWithTime){
            dateFormatter.dateFormat = DateFormat.MMMM_dd_yyyy_hh_mm
            datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        }else{
            dateFormatter.dateFormat = DateFormat.MMMM_dd_yyyy
            datePicker.datePickerMode = UIDatePickerMode.date
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        showDatePicker()
    }

    //MARK: Button Action - Cancel/Done
    @IBAction func btnAction(_ sender: AnyObject) {
     
        self.hiddeDatePicker(ServiceCallBack: { (result) -> Void in
           
            if(sender.tag == 101){}else
            if(sender.tag == 102){
                let dt : String = self.dateFormatter.string(from: self.datePicker.date)
                self.datePickerCompletion(dt)
            }
        })
    }
    
    //MARK: show/hidde methods
    func showDatePicker(){
        UIView .animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.datePickerViewBottomConstraint.constant=0
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
        })
    }
    func hiddeDatePicker(ServiceCallBack: @escaping (_ result: Bool?)-> Void! )
    {
        UIView .animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.datePickerViewBottomConstraint.constant = -380
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
                self.view.removeFromSuperview()
                return ServiceCallBack(true)
        })
    }
    
    //MARK: View Touch Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        if(touch.view == self.view){
            self.hiddeDatePicker(ServiceCallBack: { (result) -> Void in
                //code
            })
        }
    }
    
    //MARK: Date Picker function
    class func showDatePicker(displayDate : String? = "",dateFormat : String? = "", dateWithTime : Bool? = false,
                              completion pickedDate: @escaping ((_ pickedDate:String) -> () )) {
        
        let objDatePicker = DatePickerController(nibName: "DatePickerController", bundle: nil)
        objDatePicker.datePickerCompletion = pickedDate
        objDatePicker.dateWithTime = dateWithTime!
        ((dateFormat?.characters.count)! > 0) ? objDatePicker.dateFormatter.dateFormat = dateFormat! : ()
        if(displayDate!.characters.count > 0){
            // set default date like "May 18 2014"
            if let date = objDatePicker.dateFormatter.date(from: displayDate!) {
                objDatePicker.datePicker.date = date
            }
        }
        objDatePicker.appDelegate.window?.addSubview(objDatePicker.view)
        objDatePicker.appDelegate.window?.rootViewController?.addChildViewController(objDatePicker)
        objDatePicker.didMove(toParentViewController: objDatePicker.appDelegate.window?.rootViewController)
        
    }

}
