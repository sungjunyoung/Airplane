//
//  PostCell.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
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
    }
    
    //친구 삭제 ( 이분검색으로 삭제 )
    @IBAction func deleteFriend(sender: AnyObject) {
        let toDeleteIndex = UserManager.findByEmail(emailLabel.text!).index
        
        var count = 0
        for index in UserManager.nowUser.friendList{
            if index == toDeleteIndex{
                UserManager.nowUser.friendList.removeAtIndex(count)
                break;
            }
            count += 1
        }
        UserManager.updateUserInfo(UserManager.nowUser)
        //내 친구목록에서 해당친구 삭제
        
        
        let toDeleteFriend = UserManager.findByEmail(emailLabel.text!)
        count = 0
        for index in toDeleteFriend.friendList{
            if index == UserManager.nowUser.index{
                toDeleteFriend.friendList.removeAtIndex(count)
                break;
            }
            count += 1
        }
        UserManager.updateUserInfo(toDeleteFriend)
        //친구의 친구목록에서 나 삭제
        
        let alert = UIAlertView(title: "친구삭제", message: "삭제가 완료되었습니다.", delegate: nil, cancelButtonTitle: "확인")
                
        alert.show()
    }
    
    

}
