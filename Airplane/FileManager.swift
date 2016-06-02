//
//  FileManager.swift
//  Airplane
//
//  Created by junyoung on 2016. 5. 26..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation

class FileManager{
    static func updateUserFile(userList:Array<User>)->Bool{
        
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
            if user.postList.count == 0{
                outputUserList += String(-1)
            } else{
                var count2 = 0
                for post in user.postList{
                    count2 += 1
                    outputUserList += String(post.index)
                    if user.postList.count != count2{
                        outputUserList += ","
                    }
                }
            }
            outputUserList += "\n"

        }
        
        // get the documents folder url
        let documentDirectoryURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        
        
        // create the destination url for the text file to be saved
        let fileDestinationUrl = documentDirectoryURL.URLByAppendingPathComponent("test.txt")
        do{
            try outputUserList.writeToURL(fileDestinationUrl, atomically: true, encoding: NSUTF8StringEncoding)
            return true
        } catch let error as NSError {
            print("error writing to url \(fileDestinationUrl)")
            print(error.localizedDescription)
            return false
        }
        
    }
    
}