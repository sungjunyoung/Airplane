//
//  SearchCell.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var addFriendBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(name:String, email:String,group:String){
        self.nameLabel.text = name
        self.emailLabel.text = email
        self.groupLabel.text = group
        
        for i in UserManager.nowUser.friendList{
            if email == UserManager.findByIndex(i).email {
                addFriendBtn.hidden = true
                break
            }
        }
    }
    @IBAction func addFriend(sender: AnyObject) {
        var count = 0
        var requestTo = UserManager.findByEmail(emailLabel.text!)
        
        if requestTo.requestList[0] == -1{
            requestTo.requestList.removeAtIndex(0)
            requestTo.requestList.append(UserManager.nowUser.index)
        } else{
            requestTo.requestList.append(UserManager.nowUser.index)
        }
        
        UserManager.updateUserInfo(requestTo)
        
        let alert = UIAlertView(title: "친구신청", message: "친구를 요청하였습니다.", delegate: nil, cancelButtonTitle: "확인")
        
        alert.show()
    }
}