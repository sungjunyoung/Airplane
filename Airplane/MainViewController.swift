//
//  MainViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 20..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit


class MainViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var PostTableView: UITableView!
    
    var postList = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        self.hideKeyboardWhenTappedAround()
        
        
        for friendIndex in UserManager.nowUser.friendList{
            postList.appendContentsOf(UserManager.userList[friendIndex].postList)
        }
        postList.sortInPlace{(post1:Post, post2:Post)->Bool in post1.date > post2.date}
        print("mainview is loaded")
    }
    
    //keyboard Show
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -215
    }
    
    //keyboard Hide
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :PostCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PostCell
        
        let post = postList[indexPath.row]
        cell.setCell(UserManager.userList[post.userIndex].name, email: UserManager.userList[post.userIndex].email, content: post.content, date: post.date)
        
        return cell
    }
}




