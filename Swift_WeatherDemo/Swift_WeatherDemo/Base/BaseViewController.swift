//
//  BaseViewController.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        self.navigationController?.navigationBar .setBackgroundImage(UIImage.init(named :"navigationbar.png"), forBarMetrics: UIBarMetrics.Default);
        self.navigationController?.navigationBar.tintColor = UIColor.clearColor();
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor();
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent;
    }
}
