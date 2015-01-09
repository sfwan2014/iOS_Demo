//
//  MDXibView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class MDXibView: UIView {
    
    var _open:Bool?
    var open:Bool?{
        get {
            return _open
        }
        set{
            _open = newValue;
        }
    }
    
    // 闭包的用法
    lazy var block: (Bool, String) -> String = {
        [unowned self] (index: Bool, stringToProcess: String) -> String in
        // closure body goes here
        return stringToProcess;
    }
    
    var someClosure: ((Bool, String) -> String){
        
        get {
            return block;
        }
        set{
            block = newValue;
        }
    }
    
    class func loadViewFromNib(nibName:String?) ->UIView{
        let view:UIView? = NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil).last as? UIView;
        
        return view!;
    }
    
}
