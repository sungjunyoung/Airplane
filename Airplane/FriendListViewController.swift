//
//  FriendListViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 3..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit

class FriendListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var friendListTableView: UITableView!
    
    
    var friendList = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = UserManager.nowUser.name
        if UserManager.nowUser.friendList.count != 0{
            for friendIndex in UserManager.nowUser.friendList{
                friendList.append(UserManager.userList[friendIndex])
            }
        }
        
        print("friendListview is loaded")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :FriendCell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendCell
        
        
        let friend = friendList[indexPath.row]
        cell.setCell(friend.name, email: friend.email, group:friend.group)
        
        return cell
    }
}
