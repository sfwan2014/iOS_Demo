//
//  ForecastTableView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class ForecastTableView: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    var _open:Bool = false
    var open:Bool{
        get {
            return _open
        }
        set{
            _open = newValue;
        }
    }
    
    override func awakeFromNib() {
        _initViews();
    }
    
    func _initViews(){
        self.delegate = self;
        self.dataSource = self;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return 6;
    }
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier = "cellId"
            var cell:ForecastCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? ForecastCell;
            if (cell == nil) {
                cell = ForecastCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            }
            
            cell?.someClosure = {
                [unowned self] (index: Bool, stringToProcess: String) -> String in
                // closure body goes here
                
                self.open = index;
//                self.reloadData();
                var sindexPath:NSIndexPath! = NSIndexPath.init(forRow: indexPath.row+1, inSection: indexPath.section);
                self.reloadRowsAtIndexPaths([sindexPath], withRowAnimation: UITableViewRowAnimation.Fade);
                return stringToProcess;
            }
            cell?.open = self.open;
            cell?.indexPath = indexPath;
            
            return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if (indexPath.row == 0) {
            return 318;
        } else if (indexPath.row == 1) {
            if ( self.open == true) {
                return 120;
            } else {
                return 0;
            }
        } else if (indexPath.row == 2) {
            return 120;
        } else if (indexPath.row == 3) {
            return 260;
        }else if (indexPath.row == 4) {
            return 180;
        }
        return 40;
    }
    
    func scrollViewDidScroll(scrollView:UIScrollView!){
        var y:CGFloat = scrollView.contentOffset.y;
        println(y);
        
        var viewControl:UIViewController = viewController();
        if y > 90 {
            viewControl.navigationController?.navigationBar .setBackgroundImage(UIImage.init(named :"navigationbar.png"), forBarMetrics: UIBarMetrics.Default);
            self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4);
        } else {
            viewControl.navigationController?.navigationBar .setBackgroundImage(UIImage.init(named :"navigation.png"), forBarMetrics: UIBarMetrics.Default);
            self.backgroundColor = UIColor.clearColor();
        }
    }
}