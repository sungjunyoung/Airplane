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
            UserManager.deleteUserInHashTable(toDeleteUser)
            self.performSegueWithIdentifier("segSignOut", sender:self)
        }
        alert.addAction(yes)
        
        let no = UIAlertAction(title: "아니요", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(no)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}