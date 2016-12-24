//
//  AlertViewController.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

//MARK: Enum for Action Button Yes/No
enum enamAlertAction {
    case yes
    case no
}

class AlertViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: OutLets  //success
    @IBOutlet weak var subViewAlertView         : UIView!
    @IBOutlet weak var lblAlertViewTitle        : UILabel!
    @IBOutlet weak var imgAlertView             : UIImageView!
    @IBOutlet weak var msgAlertView             : UILabel!
    @IBOutlet weak var btnAlertFirst            : UIButton!
    @IBOutlet weak var btnAlertSecond           : UIButton!
    @IBOutlet weak var imaheHeight              : NSLayoutConstraint!
    
    //MARK: Variables
    var alertArray          = [Dictionary<String,String>]()
    var TitleAlert          = String()
    var MessageAlert        = String()
    var ImageAlert          = String()
    var isSuccess : Bool    = true
    var alertCompletion: ((enamAlertAction) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subViewAlertView.layer.cornerRadius    = 10
        self.imgAlertView.isHidden                  = true
        if(isSuccess){
            
            btnAlertFirst.setTitle("Ok",for: .normal)
            btnAlertSecond.isHidden = true
        }
        self.showAlertViewWithAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Show Alert With Animation
    func showAlertViewWithAnimation() {
        
        self.subViewAlertView.isHidden = false
        self.setAlertView()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            UIView.transition(with: self.subViewAlertView, duration: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.subViewAlertView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }, completion: { (finished: Bool) -> () in
                    UIView.animate(withDuration: 0.2, animations: { () -> Void in
                        self.subViewAlertView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    })
            })
            }, completion: nil)
    }
    
    //MARK: Close/Hidde Alert With Animation
    func hiddeAlertViewController(ServiceCallBack: @escaping (_ result: Bool?)-> Void! ){
        
        if(self.subViewAlertView != nil)
        {
            UIView.animate(withDuration: 0.1, animations: {
                self.subViewAlertView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: {
                    (value: Bool) in
                    self.view.removeFromSuperview()
                    return ServiceCallBack(true)
            })
        }
    }
    
    func setAlertView(){
        
        if(self.ImageAlert.characters.count > 0){
            self.imgAlertView.isHidden      = false
            self.imgAlertView.image         = UIImage(named:self.ImageAlert)
        }else{
            imaheHeight.constant = 0
        }
        self.lblAlertViewTitle.text  = self.TitleAlert
        self.msgAlertView.text       = self.MessageAlert
    }
    @IBAction func btnClose(_ sender: AnyObject) {
        self.hiddeAlertViewController { (result) -> Void in
            //code
        }
    }

    //MARK: View Touch Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        if(touch.view == self.view){
            self.hiddeAlertViewController { (result) -> Void in
            }
        }
    }
    
    @IBAction func alertViewAction(_ sender: AnyObject) {
        if(sender.tag == 101){
            self.alertCompletion(.yes)
        }else if(sender.tag == 102){
            self.alertCompletion(.no)
        }
        self.hiddeAlertViewController { (result) -> Void in}
    }
    
    //MARK: Show Alert with Call Back Methods
     class func showAlertController(alertImg : String? = "", alertTitle : String,alertMessage : String, completion completionHandler: @escaping ((enamAlertAction) -> () )) {
    
        let objAlert = AlertViewController(nibName: "AlertViewController", bundle: nil)
        objAlert.TitleAlert      = alertTitle
        objAlert.MessageAlert    = alertMessage
        objAlert.ImageAlert      = alertImg!
        objAlert.isSuccess       = false
        objAlert.alertCompletion = completionHandler
        
        objAlert.appDelegate.window?.addSubview(objAlert.view)
        objAlert.appDelegate.window?.rootViewController?.addChildViewController(objAlert)
        objAlert.didMove(toParentViewController: objAlert.appDelegate.window?.rootViewController)
    }
    
    
    class func showAlertControllerSuccess(alertImg : String? = "", alertMessage : String, completion completionHandler: @escaping ((enamAlertAction) -> () )) {
        
        let objAlert = AlertViewController(nibName: "AlertViewController", bundle: nil)
        objAlert.TitleAlert      = "Success!"
        objAlert.MessageAlert    = alertMessage
        objAlert.ImageAlert      = alertImg!
        objAlert.isSuccess       = true
        objAlert.alertCompletion = completionHandler
        
        objAlert.appDelegate.window?.addSubview(objAlert.view)
        objAlert.appDelegate.window?.rootViewController?.addChildViewController(objAlert)
        objAlert.didMove(toParentViewController: objAlert.appDelegate.window?.rootViewController)
    }
    
    
}
