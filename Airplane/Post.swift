//
//  User.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class Post{
    
    var index = -1
    var userIndex = -1
    var date = ""
    var content = ""
    
    init(){
        self.index = -1
        self.userIndex = -1
        self.date = ""
        self.content = ""
    }
    
    init(index:Int, userIndex:Int, date:String, content:String){
        self.index = index
        self.userIndex = userIndex
        self.date = date
        self.content = content
    }
}