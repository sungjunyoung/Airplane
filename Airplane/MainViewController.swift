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
    @IBOutlet weak var requestBtn: UIButton!
    var postList = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        self.hideKeyboardWhenTappedAround()
        
        postList.appendContentsOf(UserManager.nowUser.postList)
        
        for user in UserManager.userList{
            print(user.name)
            print(user.index)
            print(user.friendList)
            print(user.requestList)
            print(user.postList)
        }
        
        if UserManager.nowUser.friendList.count != 0{
            for friendIndex in UserManager.nowUser.friendList{
                for user in UserManager.userList{
                    if(user.index == friendIndex){
                        postList.appendContentsOf(user.postList)
                    }
                }
            }
        }
        for post in postList{
            print(String(post.userIndex) + post.content)
        }
        postList.sortInPlace{(post1:Post, post2:Post)->Bool in post1.date > post2.date}
        if UserManager.nowUser.requestList[0] != -1{
            requestBtn.backgroundColor = UIColor(red: 0, green: 2, blue: 4, alpha: 0)
        }
        
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
    
    @IBAction func toMyTimeLine(sender: AnyObject) {
        SaveClickInfo.set(UserManager.nowUser.email)
        self.performSegueWithIdentifier("segToUserTimeLine", sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :PostCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PostCell
        
        let post = postList[indexPath.row]
        
        
        for user in UserManager.userList{
            if user.index == post.userIndex{
                
                cell.setCell(user.name, email: user.email, content: post.content, date: post.date)
                break
            }
        }
        
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
            
            var postIndex = -1
            if ( UserManager.nowUser.postList.count == 0 ){
                postIndex = 0
            } else{
                postIndex = UserManager.nowUser.postList[UserManager.nowUser.postList.count-1].index+1
            }
            
            
            let post = Post(index: postIndex, userIndex: UserManager.nowUser.index, date: date, content: postContent!)
            
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




