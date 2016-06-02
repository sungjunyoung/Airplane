//
//  FileManager.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class FileManager{
    static func updateUserFile(userList:Array<User>, postList:Array<Post>){
        
        //////////////////////////////////////////////////////////
        var outputUserList = "" //just a text
        for user in userList{
            outputUserList += String(user.index)
            outputUserList += "/"
            outputUserList += user.email
            outputUserList += "/"
            outputUserList += user.password
            outputUserList += "/"
            outputUserList += user.name
            outputUserList += "/"
            outputUserList += user.group
            outputUserList += "/"
            if user.friendList.count == 0{
                outputUserList += String(-1)
                outputUserList += "/"
            } else{
                var count = 0
                for friendIndex in user.friendList{
                    count += 1
                    outputUserList += String(friendIndex)
                    if user.friendList.count != count{
                        outputUserList += ","
                    }
                }
                outputUserList += "/"
            }
            if user.requestList.count == 0{
                outputUserList += String(-1)
            } else{
                var count2 = 0
                for request in user.requestList{
                    count2 += 1
                    outputUserList += String(request)
                    if user.requestList.count != count2{
                        outputUserList += ","
                    }
                }
            }
            if user.index != userList[userList.count-1].index{
                outputUserList += "\n"
            }
        }
        ////////////////////////////////////////////////////////// 유저데이터 출력용 String 만들기
        var outputPostList = "" // just a text
        var postCounter = 0
        for post in postList{
            postCounter += 1
            outputPostList += String(post.index)
            outputPostList += "/"
            outputPostList += String(post.userIndex)
            outputPostList += "/"
            outputPostList += post.date
            outputPostList += "/"
            outputPostList += post.content
            if postCounter != postList.count{
                outputPostList += "\n"
            }
        }
        //////////////////////////////////////////////////////////
        
        ////////////////////////////////////////////////////////// 포스트 출력용 String 만들기
        
        
        let userfile = "userdata.txt" //this is the file. we will write to and read from it
        let postfile = "postdata.txt"
        
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let userpath = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(userfile)
            let postpath = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(postfile)
            
            //writing
            do {
                try outputUserList.writeToURL(userpath, atomically: false, encoding: NSUTF8StringEncoding)
                try outputPostList.writeToURL(postpath, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch { print("cannot write") }
        }
    }
}