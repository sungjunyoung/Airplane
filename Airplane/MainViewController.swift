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
    @IBOutlet weak var searchText: UITextField!
    var postList = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        self.hideKeyboardWhenTappedAround()
        
        if UserManager.nowUser.friendList.count != 0{
            postList.appendContentsOf(UserManager.nowUser.postList)
            for friendIndex in UserManager.nowUser.friendList{
                postList.appendContentsOf(UserManager.userList[friendIndex].postList)
            }
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
    @IBAction func toMyTimeLine(sender: AnyObject) {
        SaveClickInfo.set(UserManager.nowUser.email)
        self.performSegueWithIdentifier("segToUserTimeLine", sender: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :PostCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PostCell
        
        let post = postList[indexPath.row]
        cell.setCell(UserManager.userList[post.userIndex].name, email: UserManager.userList[post.userIndex].email, content: post.content, date: post.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as! PostCell

        
        SaveClickInfo.set(currentCell.emailLabel.text!)
        print(currentCell.emailLabel.text!)
        self.performSegueWithIdentifier("segToUserTimeLine", sender: nil)
        //CODE TO BE RUN ON CELL TOUCH
    }
    
    
    @IBAction func writePost(sender: AnyObject) {
        let alert = UIAlertController(title: "포스트 쓰기", message: "게시할 포스트를 입력하세요", preferredStyle: UIAlertControllerStyle.Alert)
        
        //add text field
        alert.addTextFieldWithConfigurationHandler{(textField:UITextField)->Void in textField.placeholder = "포스트 내용을 입력하세요"}
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default){
            (action:UIAlertAction)->Void in print("ok")
            let textField = alert.textFields?[0]
            let postContent = textField!.text
            let rawDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd.hh.mm"
            let date = dateFormatter.stringFromDate(rawDate)
            
            let post = Post(index: UserManager.nowUser.postList[UserManager.nowUser.postList.count-1].index+1, userIndex: UserManager.nowUser.index, date: date, content: postContent!)
            
            UserManager.nowUser.postList.append(post)
            UserManager.updateUserInfo(UserManager.nowUser)
            
            self.postList.append(post)
            self.postList.sortInPlace{(post1:Post, post2:Post)->Bool in post1.date > post2.date}
            self.PostTableView.reloadData()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
       
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func search(sender: AnyObject) {
        SearchText.set(searchText.text!)
         self.performSegueWithIdentifier("segSearch", sender: self)
    }
}




