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
    
}
