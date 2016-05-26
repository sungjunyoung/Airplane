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
        var rawUserList:[NSString] = userdata!.componentsSeparatedByString("\n")
        var userList = Array<User>()
        for user in rawUserList {
            var userSplit:[NSString] = user.componentsSeparatedByString("/")
            
            var stringIndex:String = userSplit[0] as String
            var index = Int(stringIndex)!
            var email = userSplit[1] as String
            var password = userSplit[2] as String
            var name = userSplit[3] as String
            var group = userSplit[4] as String
            
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
            
            var user = User(index: index,email: email,password: password,name: name,group: group,friendList: friendList,requestList: requestList)
            userList.append(user)
        } // 유저데이터 어레이 완성
        
        
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    }
    
    @IBAction func signin(sender: AnyObject) {
        self.performSegueWithIdentifier("segMain", sender: self)
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

