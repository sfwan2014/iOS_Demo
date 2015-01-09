//
//  UIView+Ext.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-8.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

extension UIView {

    func viewController()->UIViewController {
        var nextResponder:UIResponder = self.nextResponder()!;
        while !nextResponder.isKindOfClass(UIViewController .classForCoder()) {
            nextResponder = nextResponder.nextResponder()!;
        }
        
        return nextResponder as UIViewController;
    }

}
