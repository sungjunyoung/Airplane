
//
//  SaveClickInfo.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class SaveClickInfo{
    static var user = User()
    
    static func set(email: String){
        self.user = UserManager.findByEmail(email)
    }
}