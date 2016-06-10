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
                for user in UserManager.userList{
                    if user.index == friendIndex {
                        friendList.append(user)
                    }
                }
            }
        }
        
        print("friendListview is loaded")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :FriendCell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendCell
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(FriendListViewController.deleteFriend(_:)), forControlEvents: .TouchUpInside)
        
        let friend = friendList[indexPath.row]
        cell.setCell(friend.name, email: friend.email, group:friend.group)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as! FriendCell
        
        
        SaveClickInfo.set(currentCell.emailLabel.text!)
        print(currentCell.emailLabel.text!)
        self.performSegueWithIdentifier("segLookInfo", sender: nil)
        //CODE TO BE RUN ON CELL TOUCH
    }
    
    func deleteFriend(sender: AnyObject){
        self.performSegueWithIdentifier("segBack", sender:self)        
    }
    
}