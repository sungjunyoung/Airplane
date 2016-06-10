//
//  FriendPostCell.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import UIKit

class FriendPostCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postDelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(content:String, date:String){

        self.contentLabel.text = content
        self.dateLabel.text = date
        if SaveClickInfo.user.name != UserManager.nowUser.name{
            postDelBtn.hidden = true
        }
    }
    
    @IBAction func deletePost(sender: AnyObject) {
        var count = 0
        for post in UserManager.nowUser.postList{
            if post.content == self.contentLabel.text && post.date == self.dateLabel.text{
                UserManager.nowUser.postList.removeAtIndex(count)
                break
            }
            count += 1
        }
        
        UserManager.updateUserInfo(UserManager.nowUser)
        
        let alert = UIAlertView(title: "포스트 삭제", message: "삭제가 완료되었습니다.", delegate: nil, cancelButtonTitle: "확인")
        alert.show()
        
    }
    
}
