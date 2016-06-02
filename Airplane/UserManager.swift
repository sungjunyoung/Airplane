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
    static var postList = Array<Post>()
    static var emailHashTable = Array<Array<User>>()
    static var nameHashTable = Array<Array<User>>()
    static var nowUser = User()
    
    static func initUserManager(){
        userList = Array<User>()
        postList = Array<Post>()
        emailHashTable = Array<Array<User>>()
        nameHashTable = Array<Array<User>>()
        nowUser = User()
    }
    
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
    
    //이름 해시 인덱스를 리턴하는 해싱 함수
    static func nameHashingFunc(name:String) -> Int{
        var sum = 0
        for character in name.utf8{
            let stringSegment:String = "\(character)"
            sum += Int(stringSegment)!
        }
        sum = sum % 1000
        
        return sum
    }
    
    
    static func deleteUserInHashTable(user:User){
        let emailindex:Int = emailHashingFunc(user.email)
        let email = user.email
        emailHashTable[emailindex].removeAtIndex(emailBinarySearch(emailHashTable[emailindex], key:email))
        
        let nameIndex:Int = nameHashingFunc(user.name)
        let name = user.name
        nameHashTable[nameIndex].removeAtIndex(nameBinarySearch(nameHashTable[nameIndex], key:name))
    }
    
    //이메일 해시테이블을 검색하여 해당 유저를 리턴해주는 함수
    static func findByEmail(email:String) -> User{
        let index:Int = emailHashingFunc(email)
        let noUser = User()
        if( emailBinarySearch(emailHashTable[index], key: email) == -1 ){
            return noUser
        } else{
            return emailHashTable[index][emailBinarySearch(emailHashTable[index], key: email)]
        }
    }
    
    //유저의 정보를 해시테이블에 업데이트 해주는 함수
    static func updateUserInfo(user:User){
        let index:Int = emailHashingFunc(user.email)
        let email = user.email
        emailHashTable[index][emailBinarySearch(emailHashTable[index], key: email)].group = user.group
        emailHashTable[index][emailBinarySearch(emailHashTable[index], key: email)].password = user.password
        FileManager.updateUserFile(userList, postList: postList)
    }
    
    //해시테이블에서 이름으로 검색하여 유저를 리턴해주는 ㅎ마수
    static func findByName(name:String) -> User{
        let index:Int = emailHashingFunc(name)
        let noUser = User()
        if( emailBinarySearch(nameHashTable[index], key: name) == -1 ){
            return noUser
        } else{
            return nameHashTable[index][nameBinarySearch(emailHashTable[index], key: name)]
        }
    }
    
    //해시테이블 내에서 바이너리 서치 (이메일)
    static func emailBinarySearch(list:Array<User>, key:String)->Int{
        var first = 0
        var last = list.count
        
        while(first < last){
            var mid = Int((first+last)/2)
            if (key < list[mid].email){
                last = mid;
            } else if (key > list[mid].email){
                first = mid + 1
            } else{
                return mid
            }
        }
        return -(first+1)
    }
    
    
    static func nameBinarySearch(list:Array<User>, key:String)->Int{
        var first = 0
        var last = list.count
        
        while(first < last){
            var mid = Int((first+last)/2)
            if (key < list[mid].name){
                last = mid;
            } else if (key > list[mid].name){
                first = mid + 1
            } else{
                return mid
            }
        }
        return -(first+1)
    }
    
    
    

}