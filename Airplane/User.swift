//
//  User.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class User{
    
    var index = -1
    var email = ""
    var password = ""
    var name = ""
    var group = ""
    var friendList = Array<Int>()
    var requestList = Array<Int>()
    
    init(index:Int, email:String, password:String, name:String, group:String, friendList:Array<Int>, requestList:Array<Int>){
        self.index = index
        self.email = email
        self.password = password
        self.name = name
        self.group = group
        self.friendList = friendList
        self.requestList = requestList
    }
}