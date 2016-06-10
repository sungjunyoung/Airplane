//
//  SettingViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 30..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController : UIViewController{
    @IBOutlet weak var newGroupTextfield: UITextField!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var newVerifyPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        //키보드 뜨는지
        self.hideKeyboardWhenTappedAround()
        
        newGroupTextfield.text = UserManager.nowUser.group
        newPasswordTextfield.text = UserManager.nowUser.password
        newVerifyPasswordTextfield.text = UserManager.nowUser.password
    }
    
    @IBAction func updateInfo(sender: AnyObject) {
        if (newPasswordTextfield.text != newVerifyPasswordTextfield.text){
            passwordAlert()
            return
        }
        else{
            let updatedGroup = newGroupTextfield.text
            let updatedPassword = newPasswordTextfield.text
            let nowUser = UserManager.nowUser
            
            UserManager.nowUser.group = updatedGroup!
            UserManager.nowUser.password = updatedPassword!
            
            UserManager.userList[nowUser.index].group = updatedGroup!
            UserManager.userList[nowUser.index].password = updatedPassword!
            
            UserManager.updateUserInfo(nowUser)
            completeAlert()
        }
       
        
    }
    
    @IBAction func signOut(sender: AnyObject) {
        signOutAlert()
    }
    
    func passwordAlert(){
        let alert = UIAlertController(title: "비밀번호 불일치", message: "비밀번호가 일치하는지 확인해주세요", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func completeAlert(){
        let alert = UIAlertController(title: "완료", message: "정보수정이 완료되었습니다.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func signOutAlert(){
        let alert = UIAlertController(title: "회원탈퇴", message: "정말 회원탈퇴를 하시겠습니까?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let yes = UIAlertAction(title: "예", style: UIAlertActionStyle.Default){
            (action:UIAlertAction)->Void in print("OK")
            let toDeleteUser = UserManager.nowUser
            var counter = 0
            for user in UserManager.userList{
                if user.email == toDeleteUser.email{
                    UserManager.userList.removeAtIndex(counter)
                    break
                }
                counter += 1
            }
            
            var c = 0
            for user in UserManager.userList{
                var count = 0
                for i in user.friendList{
                    if UserManager.nowUser.index == i{
                        UserManager.userList[c].friendList.removeAtIndex(count)
                    }
                    count += 1
                }
                
                count = 0
                for j in user.requestList{
                    if UserManager.nowUser.index == j{
                        UserManager.userList[c].requestList.removeAtIndex(count)
                        if user.requestList.count == 0{
                            UserManager.userList[c].requestList.append(-1)
                            break
                        }
                    }
                    count += 1
                }
                c += 1
            }
            UserManager.deleteUserInHashTable(toDeleteUser)
            
            self.performSegueWithIdentifier("segSignOut", sender:self)
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "아니요", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(no)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //keyboard Show
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    //keyboard Hide
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}