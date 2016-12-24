//
//  ActionSheetCell.swift
//  CustomActionSheet
//
//  Created by JadavMehul on 16/12/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var actionImage      : UIImageView!
    @IBOutlet weak var cellView         : UIView!
    @IBOutlet weak var actionTitle      : UILabel!
    @IBOutlet weak var actionSubTitle   : UILabel!
    @IBOutlet weak var viewImageWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actionTitle.font                = UIFont.systemFont(ofSize: 15)
        actionSubTitle.font             = UIFont.systemFont(ofSize: 12)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: Initilization Values
    public func initWithObject(dictData: [String: String]){
        actionSubTitle.isHidden = true
        if(dictData[ActionKey.Title]! == "Cancle"){
            actionTitle.font = UIFont.boldSystemFont(ofSize: 16)
        }
        if(dictData[ActionKey.Image]!.characters.count > 0){
            actionImage.image     = UIImage(named:dictData[ActionKey.Image]!)
        }else{
            viewImageWidth.constant = 0
        }
        actionTitle.text      = dictData[ActionKey.Title]!
        if(dictData[ActionKey.SubTitle]!.characters.count > 0){
            actionSubTitle.isHidden   = false
            actionSubTitle.text       = dictData[ActionKey.SubTitle]!
        }
    }
}
