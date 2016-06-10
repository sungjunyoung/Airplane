//
//  MainViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 20..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit



class SignupViewController : UIViewController{

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifypasswordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func back(sender: AnyObject) {self.performSegueWithIdentifier("segSignupToIntro", sender: self)
    }
    
    //keyboard Show
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    //keyboard Hide
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func signUp(sender: AnyObject) {
        if(emailTextField.text == "" || passwordTextField.text == "" || verifypasswordTextField.text == "" || nameTextField.text == "" || nameTextField.text == "" || groupTextField.text == ""){
            comfirmAlert()
            return
        } else{
            if(passwordTextField.text != verifypasswordTextField.text){
                passwordAlert()
                return
            } else{
                for i in UserManager.userList{
                    if emailTextField.text == i.email{
                        emailAlert()
                        return
                    }
                }
                var user = User()
                user.index = UserManager.userList[UserManager.userList.count-1].index+1
                user.email = emailTextField.text!
                user.password = passwordTextField.text!
                user.name = nameTextField.text!
                user.group = groupTextField.text!
                user.requestList.append(-1)
                
                
                UserManager.userList.append(user)
                UserManager.emailHashTable[UserManager.emailHashingFunc(user.email)].append(user)
                UserManager.nameHashTable[UserManager.nameHashingFunc(user.name)].append(user)
                FileManager.updateUserFile(UserManager.userList,postList:UserManager.postList)
                completeAlert()
            }
        }
        //회원가입을 누르면 파일에 출력
    }
    
    func completeAlert(){
        let alert = UIAlertController(title: "완료", message: "회원가입 완료", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default){
            (action:UIAlertAction)->Void in print("OK")
            self.performSegueWithIdentifier("segSignupToIntro", sender: self)
        }
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func comfirmAlert(){
        let alert = UIAlertController(title: "빈항목 발견", message: "모든 항목을 빠짐없이 기입해 주세요.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
    
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func passwordAlert(){
        let alert = UIAlertController(title: "비밀번호 불일치", message: "비밀번호가 일치하는지 확인해주세요", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func emailAlert(){
        let alert = UIAlertController(title: "동일 이메일 존재", message: "다른 이메일을 사용해 주세요", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "확인", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}




