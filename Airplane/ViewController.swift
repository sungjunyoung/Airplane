//
//  ViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 19..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import UIKit



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class ViewController: UIViewController{
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        //키보드 뜨는지
        self.hideKeyboardWhenTappedAround()
        
        let path = NSBundle.mainBundle().pathForResource("userdata", ofType: "txt")
        
        var userdata: String? = nil
        do {
            userdata = try String(contentsOfFile: path!, encoding:NSUTF8StringEncoding)
        } catch _ as NSError {
                print("error!")
        }
        
        ///////////////////////////////////////유저데이터 어레이, 해시테이블 + 포스트 어레이 만들기//////////////////////////////////////
        let rawUserList:[NSString] = userdata!.componentsSeparatedByString("\n")
        var userList = Array<User>()
        for user in rawUserList {
            var userSplit:[NSString] = user.componentsSeparatedByString("/")
            
            let stringIndex:String = userSplit[0] as String
            let index = Int(stringIndex)!
            let email = userSplit[1] as String
            let password = userSplit[2] as String
            let name = userSplit[3] as String
            let group = userSplit[4] as String
            
            let rawFriendList:[NSString] = userSplit[5].componentsSeparatedByString(",")
            let rawRequestList:[NSString] = userSplit[6].componentsSeparatedByString(",")
            
            var friendList = Array<Int>()
            var requestList = Array<Int>()
            
            for friend in rawFriendList{
                let stringFriend = friend as String
                friendList.append(Int(stringFriend)!)
            }
            for request in rawRequestList{
                let stringRequest = request as String
                requestList.append(Int(stringRequest)!)
            }
            
            let user = User(index: index,email: email,password: password,name: name,group: group,friendList: friendList,requestList: requestList)
            userList.append(user)
        } // 유저데이터 어레이
        
        //이메일 해시테이블 생성
        var emailHashTable = Array<Array<User>>()
        var tempList1 = Array<User>()
        for (var i=0; i<1000 ; i++){
            emailHashTable.append(tempList1)
        }
        
        for user in userList{
            var sum = 0
            for character in user.email.utf8{
                let stringSegment:String = "\(character)"
                sum += Int(stringSegment)!
            }
            sum = sum % 1000
            emailHashTable[sum].append(user)
        }
        
        //이름 해시테이블 생성
        var nameHashTable = Array<Array<User>>()
        var tempList2 = Array<User>()
        for i in 0..<1000 {
            nameHashTable.append(tempList2)
        }
        
        for user in userList{
            var sum = 0
            for character in user.name.utf8{
                let stringSegment:String = "\(character)"
                sum += Int(stringSegment)!
            }
            sum = sum % 1000
            nameHashTable[sum].append(user)
        }
        
        
      
        //해시테이블에 잘 들어갓나 확인
        print("이메일")
        var i = 0 , j = 0
        for userLi in emailHashTable{
            j=0
            for user in userLi{
                print(i," ",j," ",user.email)
                j+=1
            }
            i+=1
        }
        print("이름")
        i = 0
        for userLi in nameHashTable{
            j = 0
            for user in userLi{
                print(i," ",j," ",user.name)
                j+=1
            }
            i+=1
        }
        
        UserManager.userList = userList
        UserManager.emailHashTable = emailHashTable
        UserManager.nameHashTable = nameHashTable
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    }
    
    @IBAction func signin(sender: AnyObject) {
        let tempUser:User = UserManager.findByEmail(self.emailTextBox!.text!)
        // 해시테이블에서 유저를 찾아 로그인 하게한다.
        
        if tempUser.index == -1{ // 유저를 찾지 못햇다면
            print("incorrect email")
        }
        else{
            if tempUser.password == self.passwordTextBox!.text!{
                //이메일과 패스워드가 모두 일치 할 때 로그인 가능
                self.performSegueWithIdentifier("segMain", sender: self)
            }
            else {
                print("incorrect password")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let sendtimer=segue.destinationViewController as! MainView
        //sendtimer.time=String(time)
        
    }

    @IBAction func signup(sender: AnyObject) {
        self.performSegueWithIdentifier("segSignup", sender: self)
        
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

