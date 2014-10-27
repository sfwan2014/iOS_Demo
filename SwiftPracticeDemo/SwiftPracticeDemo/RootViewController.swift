//
//  RootViewController.swift
//  SwiftPracticeDemo
//
//  Created by sfwan on 14-8-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.setTitle("点击", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRect(x:100, y:150, width:100, height:40)
        button.addTarget(self, action: Selector("buttonAction"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        self.view.backgroundColor = UIColor.magentaColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction () {
        var url = NSURL(string:"http://www.baidu.com")
        var request = NSURLRequest(URL: url)
        var queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:callBack)
    }
    
    func callBack(#response: NSURLResponse!, data: NSData!, error: NSError!){
        var string = NSString(data: data, encoding: NSUTF8StringEncoding)
        println(string)
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
