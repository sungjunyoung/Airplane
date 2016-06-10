//
//  UserTimeLineViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit


class UserTimeLineViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var cardGroupLabel: UILabel!
    @IBOutlet weak var cardEmailLabel: UILabel!
    
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postTableView: UITableView!
    
    var postList = Array<Post>()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        cardGroupLabel.text = SaveClickInfo.user.group
        ownerName.text = SaveClickInfo.user.name
        cardEmailLabel.text = SaveClickInfo.user.email
        
        for post in SaveClickInfo.user.postList{
            postList.append(post)
        }
        postList.sortInPlace{(post1:Post, post2:Post)->Bool in post1.date > post2.date}
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return postList.count
        return postList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :FriendPostCell = tableView.dequeueReusableCellWithIdentifier("friendPostCell") as! FriendPostCell
        
        let post = postList[indexPath.row]
        
        cell.setCell(post.content, date: post.date)
        
        return cell
        
    }
}
