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
    static var nowUser = User()
    
    //이메일 해시 인덱스를 리턴하는 해싱 함수
    static func emailHashingFunc(email:String) -> Int{
        var sum = 0
        for character in email.utf8{
            let stringSegment:String = "\(character)"
            sum += Int(stringSegment)!
        }
        sum = sum % 1000

        return sum
    }
    
    //이메일 해시테이블을 검색하여 해당 유저를 리턴해주는 함수
    static func findByEmail(email:String) -> User{
        let index:Int = emailHashingFunc(email)
        
        ///////////////////////////////// => 이분검색으로 바꿔야함
        for user in emailHashTable[index]{
            if user.email == email {
                return user
            }
        }
        ////////////////////////////////
        
        
        let incorrectUser = User()
        
        return incorrectUser
    }
}