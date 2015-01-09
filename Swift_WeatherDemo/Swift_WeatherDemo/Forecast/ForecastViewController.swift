//
//  ForecastViewController.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class ForecastViewController: BaseViewController {
    @IBOutlet weak var tableView: ForecastTableView!
    override func viewDidLoad() {
        super.viewDidLoad();
    self.navigationController?.navigationBar .setBackgroundImage(UIImage.init(named :"navigation.png"), forBarMetrics: UIBarMetrics.Default);
        
        _initViews();
    }
    
    func _initViews(){
        _setTitle();
        _setBackground();
        _setNavgationItems();
        
        _initTableView();
    }
    
    func _setTitle(){
        let x:CGFloat = self.navigationController!.navigationBar.frame.size.width/2-35 as CGFloat;
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
        button.setTitle("+海淀!", forState: UIControlState.Normal);
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted);
        button.frame = CGRectMake(x, 0, 100, 40);
        self.navigationController?.navigationBar.addSubview(button as UIView);
    }
    
    func _setBackground(){
        let image:UIImage? = UIImage.init(named:"forecast_bg.png");
//        let color:UIColor? = UIColor.init(patternImage:image!);
        self.view.backgroundColor = UIColor.init(patternImage:image!);
    }
    
    func _setNavgationItems(){
        let leftBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom)as UIButton;

        leftBtn.frame = CGRectMake(0, 0, 25, 25);
        leftBtn.tag = 1;
    leftBtn.setBackgroundImage(UIImage.init(named:"forecast_navigationbar_icon_voice_normal"), forState: UIControlState.Normal);leftBtn.setBackgroundImage(UIImage.init(named:"forecast_navigationbar_icon_voice_hilight.png"), forState: UIControlState.Highlighted);
        leftBtn.addTarget(self, action: Selector("btnAction:"), forControlEvents: UIControlEvents.TouchUpInside);
        let leftItem:UIBarButtonItem = UIBarButtonItem.init(customView: leftBtn);
        
        
        let rightBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom)as UIButton;
        rightBtn.frame = CGRectMake(0, 0, 25, 25);
        rightBtn.tag = 2;
        rightBtn.setBackgroundImage(UIImage.init(named:"menu_normal.png"), forState: UIControlState.Normal);rightBtn.setBackgroundImage(UIImage.init(named:"menu_hilight.png"), forState: UIControlState.Highlighted);
        rightBtn.addTarget(self, action: Selector("btnAction:"), forControlEvents: UIControlEvents.TouchUpInside);
        let rightItem:UIBarButtonItem = UIBarButtonItem.init(customView: rightBtn);
        
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    func _initTableView(){
        
    }
    
    func btnAction(button:UIButton!){
        if (button.tag == 1 ){
        
        } else if (button.tag == 2) {
        
        }
    }
}
