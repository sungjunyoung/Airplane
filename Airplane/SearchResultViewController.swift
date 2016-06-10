//
//  SearchResultViewController.swift
//  Airplane
//
//  Created by junyoung on 2016. 6. 10..
//  Copyright © 2016년 tgwing. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var searchWhat: UILabel!
    
    var searchResultList = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchWhat.text = SearchText.searchText
        if (SearchText.searchText.rangeOfString("@") != nil){
        searchResultList.append(UserManager.findByEmail(SearchText.searchText))
        }
        else {
            searchResultList.appendContentsOf(UserManager.findByName(SearchText.searchText))
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell :SearchCell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath:indexPath) as! SearchCell
        //cell.deleteBtn.tag = indexPath.row
        //cell.deleteBtn.addTarget(self, action: #selector(FriendListViewController.deleteFriend(_:)), forControlEvents: .TouchUpInside)
        
        let search = searchResultList[indexPath.row]
        cell.setCell(search.name, email: search.email, group:search.group)
        
        return cell
    }
}