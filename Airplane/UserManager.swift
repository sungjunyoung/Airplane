//
//  UserManager.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class UserManager{
    
    static var userList = Array<User>()
    static var emailHashTable = Array<Array<User>>()
    static var nameHashTable = Array<Array<User>>()
    
    static func emailHashingFunc(email:String) -> Int{
        var sum = 0
        for character in email.utf8{
            let stringSegment:String = "\(character)"
            sum += Int(stringSegment)!
        }
        sum = sum % 1000

        return sum
    }
    
    static func findByEmail(email:String) -> User{
        var index:Int = emailHashingFunc(email)
        
        ///////////////////////////////// => 이분검색으로 바꿔야함
        for user in emailHashTable[index]{
            if user.email == email {
                return user
            }
        }
        ////////////////////////////////
        
        
        let incorrectfriendList = Array<Int>()
        let incorrectrequestList = Array<Int>()
        let incorrectUser = User(index: -1, email: "", password: "", name: "", group: "", friendList: incorrectfriendList, requestList: incorrectrequestList)
        
        return incorrectUser
    }
}