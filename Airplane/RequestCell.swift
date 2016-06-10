//
//  RequestCell.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//


import UIKit

class RequestCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(name:String, email:String, group:String){
        self.nameLabel.text = name
        self.emailLabel.text = email
        self.groupLabel.text = group
    }
    
    @IBAction func acceptRequest(sender: AnyObject) {
        var count = 0
        var requestedUser = User()
        for i in UserManager.nowUser.requestList{
            if(emailLabel.text! == UserManager.findByIndex(i).email){
                UserManager.nowUser.requestList.removeAtIndex(count)
                if UserManager.nowUser.requestList.count == 0{
                    UserManager.nowUser.requestList.append(-1)
                }
                UserManager.nowUser.friendList.append(i)
                UserManager.findByIndex(i).friendList.append(UserManager.nowUser.index)
                requestedUser = UserManager.findByIndex(i)
                break
            }
            count += 1
        } //요청 리스트에 있는 요청 지우기
        
        UserManager.updateUserInfo(UserManager.nowUser)
        UserManager.updateUserInfo(requestedUser)
        
        let alert = UIAlertView(title: "요청 수락", message: "친구추가가 완료되었습니다.", delegate: nil, cancelButtonTitle: "확인")
        
        alert.show()
    }
    
    @IBAction func deleteRequest(sender: AnyObject) {
        var count = 0
        for i in UserManager.nowUser.requestList{
            if(emailLabel.text! == UserManager.findByIndex(i).email){
                UserManager.nowUser.requestList.removeAtIndex(count)
                if UserManager.nowUser.requestList.count == 0{
                    UserManager.nowUser.requestList.append(-1)
                }
            }
            count += 1
        }
        let alert = UIAlertView(title: "요청 거절", message: "친구 요청을 거절하였습니다.", delegate: nil, cancelButtonTitle: "확인")
        
        alert.show()
    }
}
