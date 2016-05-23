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
        
        var fileContents: String? = nil
        do {
            fileContents = try String(contentsOfFile: path!, encoding:NSUTF8StringEncoding)
        } catch _ as NSError {
                print("error!")
        }
        
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

