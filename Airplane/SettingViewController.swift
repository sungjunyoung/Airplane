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
        
    }
}