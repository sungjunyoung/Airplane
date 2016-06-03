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
    
}
