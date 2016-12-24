//
//  ViewController.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var actionSheet          : UIButton!
    @IBOutlet weak var alertViewController  : UIButton!
    @IBOutlet weak var alertSuccess         : UIButton!
    @IBOutlet weak var datePicker           : UIButton!
    @IBOutlet weak var pickerController     : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FibonacciNumber()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadCart(){
        
    }
    
    //MARK: Button Actions
    @IBAction func btnActionSheet(_ sender: AnyObject) {

        self.getActionSheet()
    }
    
    @IBAction func btnAlertViewController(_ sender: AnyObject) {
        let str:String = "Your Safari Item is listed \n successfully!Your Safari Item is listed "
        AlertViewController.showAlertController(alertImg: "safari", alertTitle: "Your Title", alertMessage: str) { (completionHandler) in
            
            switch completionHandler{
            case .yes:
                self.AlertMessage(msg: "You have selected Yes")
                break
            case .no:
                self.AlertMessage(msg: "You have selected No")
                break
                //default: break
            }
        }
    }
    
    @IBAction func btnSuccessAlert(_ sender: AnyObject) {
        
        let str:String = "Your Comment Item is listed \n successfully! Your Comment is listed "
        AlertViewController.showAlertControllerSuccess(alertImg: "comment", alertMessage: str) { (completionHandler) in
            //code
            switch completionHandler{
            case .yes:
                break
            default: break
            }
        }
        
    }
    
    @IBAction func btnDatePicker(_ sender: AnyObject) {
        
        DatePickerController.showDatePicker(displayDate: "", dateFormat: "", dateWithTime: false) {
            (date) in
            self.AlertMessage(msg: "Date: "+date)
        }
    }
    
    @IBAction func btnPickerController(_ sender: AnyObject) {

        let arr = ["Apple", "Apricot", "Avocado", "Banana", "Bilberry", "Blackberry", "Blackcurrant", "Blueberry"]
        PickerController.showPicker(pickerArray: arr, selectedPicker: "Avocado") { (result, index) in
            //code
            self.AlertMessage(msg: result+" : "+String(index))
        }
    }
    
    func getActionSheet(){
        
        let arrAcationSheetData: [[String: String]] = [
            [ActionKey.Title: ActionSheetData.strSafari, ActionKey.SubTitle: ActionSheetData.strSubTitleSafari, ActionKey.Image: ActionSheetData.imgSafari],
            [ActionKey.Title: ActionSheetData.strComment, ActionKey.SubTitle: ActionSheetData.strSubTitleComment, ActionKey.Image: ActionSheetData.imgComment],
            [ActionKey.Title: ActionSheetData.strTweet, ActionKey.SubTitle: ActionSheetData.strSubTitleTweet, ActionKey.Image: ActionSheetData.imgTweet],
            [ActionKey.Title: ActionSheetData.strSafari, ActionKey.SubTitle: ActionSheetData.strSubTitleSafari, ActionKey.Image: ActionSheetData.imgSafari],
            [ActionKey.Title: ActionSheetData.strComment, ActionKey.SubTitle: ActionSheetData.strSubTitleComment, ActionKey.Image: ActionSheetData.imgComment],
            [ActionKey.Title: ActionSheetData.strTweet, ActionKey.SubTitle: ActionSheetData.strSubTitleTweet, ActionKey.Image: ActionSheetData.imgTweet]
        ]
        ActionSheetVC.showActionSheetWithOption(optionToDisplay: arrAcationSheetData) { (completionHandler) in
            //code
            switch completionHandler {
            case .Safari:
                self.AlertMessage(msg: ""+ActionSheetData.strSafari)
                break
            case .Comment:
                self.AlertMessage(msg: ""+ActionSheetData.strComment)
                break
            case .Tweet:
                self.AlertMessage(msg: ""+ActionSheetData.strTweet)
                break
            //default: break
            }
        }
    }
    
    //MARK: Alert Function
    func AlertMessage(msg:String){
        
        let alertController = UIAlertController(title: "Action", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Extra functions
    func example(){
        var arrayMenuOptions = [Dictionary<String,String>]()
        arrayMenuOptions.append(["title":"Home", "icon":"HomeIcon"])
        arrayMenuOptions.append(["title":"Play", "icon":"PlayIcon"])
        (arrayMenuOptions.count > 0) ? print("True") : print("False")
        
        for i in (0..<arrayMenuOptions.count){
            print("Title: ",arrayMenuOptions[i]["title"]!," | Icon: ",arrayMenuOptions[i]["icon"]!)
        }
    }
    func serachTxt(){
        let string = "hello Swift"
        if string.localizedLowercase.range(of: "Swift") != nil {
            print("exists")
        }
    }
    func predicate(){
        var arrayMenuOptions = [Dictionary<String,String>]()
        var arrayMenuOptionsTemp = [Dictionary<String,String>]()
        arrayMenuOptions.append(["title":"Home", "icon":"HomeIcon"])
        arrayMenuOptions.append(["title":"Play", "icon":"PlayIcon"])
        arrayMenuOptions.append(["title":"Game", "icon":"GameIcon"])
        arrayMenuOptions.append(["title":"Store", "icon":"StoreIcon"])
//        let key1:String = "title"
//        let key2:String = "icon"
        let searchText1:String = "play"
        let searchText2:String = "store"
        let resultPredicate = NSPredicate(format: "title contains[c] %@ or icon contains[c] %@", searchText1,searchText2)
        arrayMenuOptionsTemp = (arrayMenuOptions as NSArray).filtered(using: resultPredicate) as! [Dictionary<String, String>]
        print(arrayMenuOptionsTemp)
    }
    func simpleQueuws(){
        
        let queue1 = DispatchQueue(label: "com.demo.queue1", qos:DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.demo.queue2", qos:DispatchQoS.utility)
        queue1.async {
            for i in 0..<10{
                print("RED",i)
            }
        }
        queue2.async {
            for i in 100..<110{
                print("BLUE",i)
            }
        }
    }
    
    func optionalValue(){
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        print(informalGreeting)
        // String literal
        let a = "Hello World!"
        // Check if there is a specific Suffix
        if a.hasSuffix("World!") {
            print("Yes, there is")
        }
        else {
            print("Error! ")
        }
    }
    
    func FibonacciNumber(){
        var first = 0
        var second = 1
        var next:Int!
        for i in 0..<10{
            if(i <= 1){
                next = i
            }else{
                next = first+second
                first = second
                second = next
            }
            print(next)
        }
    }
    
    
}


