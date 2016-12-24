//
//  PickerController.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class PickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Declare variables
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var pickerArray = [String]()
    var pickerCompletion: ((_ pickedString:String,_ pickedIndex:Int) -> ())!
    var pickedString : String = ""
    var pickedIndex : Int = 0
    var selectedRow : Int = 0
    
    //MARK: All Outlets
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var pickerController     : UIPickerView!
    @IBOutlet weak var viewBottomConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewBottomConstraint.constant = -265
        pickerController.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        showPicker()
    }
    
    //MARK: Done Button
    @IBAction func btnDone(_ sender: AnyObject) {
        
        self.hiddePicker { (result) -> Void in
            self.pickerCompletion(self.pickedString,self.pickedIndex)
        }
    }
    
    //MARK: Cancel Button
    @IBAction func btnCancel(_ sender: AnyObject) {
        self.hiddePicker { (result) -> Void in }
    }
    
    //MARK: PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedString = pickerArray[row]
        pickedIndex = row
    }
    
    //MARK: show/hidde methods
    private func showPicker(){
        UIView .animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.viewBottomConstraint.constant=0
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
        })
    }
    private func hiddePicker(ServiceCallBack: @escaping (_ result: Bool?)-> Void! )
    {
        UIView .animate(withDuration: 0.3, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.viewBottomConstraint.constant = -265
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
            self.hiddePicker(ServiceCallBack: { (result) -> Void in
                //code
            })
        }
    }

    //MARK: Get Index from StringArray
    func getIndexOfArray(pickerArray:[String], str:String) -> Int {
        for i in (0..<pickerArray.count){
            if(pickerArray[i] == str){ return i }
        }
        return 0
    }
    
    //MARK: Date Picker function
    class func showPicker(pickerArray : [String], selectedPicker : String? = "", completion pickedString: @escaping ((_ pickedString:String,_ pickedIndex:Int) -> () )) {
        
        let objPicker = PickerController(nibName: "PickerController", bundle: nil)
        objPicker.pickerArray = pickerArray
        objPicker.pickerCompletion = pickedString
        if((selectedPicker?.characters.count)! > 0){
            objPicker.selectedRow   = objPicker.getIndexOfArray(pickerArray: pickerArray, str: selectedPicker!)
            objPicker.pickedString  = pickerArray[objPicker.selectedRow]
            objPicker.pickedIndex   = objPicker.selectedRow
        }
        
        objPicker.appDelegate.window?.addSubview(objPicker.view)
        objPicker.appDelegate.window?.rootViewController?.addChildViewController(objPicker)
        objPicker.didMove(toParentViewController: objPicker.appDelegate.window?.rootViewController)
    }
}
