//
//  RootViewController.swift
//  SwiftUIViewDemo
//
//  Created by shaofa on 14-6-12.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

import UIKit

class RootViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView : UITableView
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view!.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        
        let identify = "CellId"
        var cell:UITableViewCell!
//        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:identify)
        }
        
        cell.textLabel.text = "12345"
        return cell
    }

}
