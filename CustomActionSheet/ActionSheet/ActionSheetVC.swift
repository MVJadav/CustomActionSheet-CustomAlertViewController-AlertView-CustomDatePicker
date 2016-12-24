//
//  ActionSheetVC.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

//MARK: Enum for Action Sheet
enum enumActionSheetOption {
    case Safari,
         Comment,
         Tweet
}

//MARK: Declare All Action Sheet Here
struct ActionSheetData {
    
    //MARK: Action Images
    static let imgSafari                = "safari"
    static let imgComment               = "comment"
    static let imgTweet                 = "tweet"
    //MARK: Action Title
    static let strSafari                = "Safari"
    static let strComment               = "Comment"
    static let strTweet                 = "Tweet"
    //MARK: Action Suntitle
    static let strSubTitleSafari        = "Subtitle Safari"
    static let strSubTitleComment       = "Subtitle Comment"
    static let strSubTitleTweet         = "Subtitle Tweet"
}
//MARK: ActionSheet Array Keys
struct ActionKey{
    static let Title                    = "Title"
    static let Image                    = "Image"
    static let SubTitle                 = "SubTitle"
}

class ActionSheetVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Outlets
    @IBOutlet weak var tblHeightConstrint   : NSLayoutConstraint!
    @IBOutlet weak var tblBottomConts       : NSLayoutConstraint!
    @IBOutlet weak var tblActionSheet       : UITableView!
    @IBOutlet weak var subView              : UIView!
    @IBOutlet weak var btnCancel            : UIButton!
    
    //MARK: Variables
    var actionArray : [[String: String]]!   = []
    var isDestructive : Bool                = false
    var Destructive : Int                   = 0
    var actionSheetCompletion: ((enumActionSheetOption) -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblActionSheet.layer.cornerRadius      = 10
        self.btnCancel.layer.cornerRadius           = 10
        self.tblActionSheet.reloadData()
        self.tblHeightConstrint.constant    = tblActionSheet.contentSize.height + 60
        self.tblBottomConts.constant        = -(self.tblHeightConstrint.constant)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        showActionSheet()
    }
    
    //MARK: Show/Hidde Action
    func showActionSheet(){
        UIView .animate(withDuration: 0.2, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.tblBottomConts.constant=0
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
        })
    }
    func hiddeActionSheet(ServiceCallBack: @escaping (_ result: Bool?)-> Void! )
    {
        UIView .animate(withDuration: 0.2, delay: 0.0, options:UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.tblBottomConts.constant = -self.tblHeightConstrint.constant//-335
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in
                self.view.removeFromSuperview()
                return ServiceCallBack(true)
        })
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return actionArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cell:ActionSheetCell? = tableView.dequeueReusableCell(withIdentifier: "ActionSheetCell") as? ActionSheetCell
        if (cell == nil) {
            let nib: NSArray = Bundle.main.loadNibNamed("ActionSheetCell", owner: self, options: nil)! as NSArray
            cell = nib.object(at: 0) as? ActionSheetCell
        }
        let dictData: [String: String] = self.actionArray[indexPath.row]
        if((isDestructive) && (Destructive == indexPath.row )){
            cell?.actionTitle.textColor = UIColor.red
        }
        cell?.initWithObject(dictData: dictData)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        self.hiddeActionSheet { (result) -> Void in
            let dictData: [String: String] = self.actionArray[indexPath.row]
            let strTitle = dictData[ActionKey.Title]
            if strTitle == ActionSheetData.strSafari {
                self.actionSheetCompletion(.Safari)
            }else if strTitle == ActionSheetData.strComment {
                self.actionSheetCompletion(.Comment)
            }else if strTitle == ActionSheetData.strTweet {
                self.actionSheetCompletion(.Tweet)
            }
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: Cancel Button
    @IBAction func cancelButton(_ sender: AnyObject) {
        self.hiddeActionSheet { (result) -> Void in
        }
    }
    
    //MARK: View Touch Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first! as UITouch
        if(touch.view == self.view){
            self.hiddeActionSheet { (result) -> Void in
            }
        }
    }
    
    //MARK: show action sheet method with completion handler
    class func showActionSheetWithOption(optionToDisplay arrData:[[String: String]], destructive : Int? = 0, completion completionHandler: @escaping ((enumActionSheetOption) -> () )) {
        
        let objActionSheet = ActionSheetVC(nibName: "ActionSheetVC", bundle: nil)
        objActionSheet.actionArray = arrData
        objActionSheet.actionSheetCompletion = completionHandler
        if(destructive! > 0){
            objActionSheet.isDestructive   = true
            objActionSheet.Destructive     = destructive!
        }
        
        objActionSheet.appDelegate.window?.addSubview(objActionSheet.view)
        objActionSheet.appDelegate.window?.rootViewController?.addChildViewController(objActionSheet)
        objActionSheet.didMove(toParentViewController: objActionSheet.appDelegate.window?.rootViewController)
        
        objActionSheet.tblActionSheet.reloadData()
    }
}
