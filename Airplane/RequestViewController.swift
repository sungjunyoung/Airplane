//
//  RequestViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit

class RequestViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var requestList = Array<User>()
    @IBOutlet weak var requestNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.nowUser.requestList[0] != -1 {
            requestNumber.text = String(UserManager.nowUser.requestList.count)
        
            for i in UserManager.nowUser.requestList{
                requestList.append(UserManager.findByIndex(i))
            }
        } else {
            requestNumber.text = "0"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestList.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        
        let cell :RequestCell! = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath:indexPath) as! RequestCell
        
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(RequestViewController.acceptFriend(_:)),forControlEvents: .TouchUpInside)
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(RequestViewController.acceptFriend(_:)),forControlEvents: .TouchUpInside)
        
        let request = requestList[indexPath.row]
        
        print(request.name + " " + request.email + " " + request.group)
        cell.setCell(request.name, email:request.email,group:request.group)
        
        return cell
    }
    
    func acceptFriend(sender: AnyObject){
        self.performSegueWithIdentifier("segBackToSocial", sender:self)
    }
}
