//
//  PullScrollView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

protocol PullScrollViewDataSource{
    func pullScrollView(pullScrollView: PullScrollView, numberOfRowsInSection section: Int) -> Int
    
    func numberOfSectionsInTableView(pullScrollView: PullScrollView) -> Int
}

class PullScrollView: UIScrollView {

//    unowned(unsafe) var dataSource: PullScrollViewDataSource?
    
    var data:NSArray {
        get{
            return _data!
        }
        
        set{
            _data = newValue
            self.reloadData()
        }
    }
    
    func reloadData(){
        self._initViews()
    }
    
    private
    var _data:NSArray?
    private
    func _initViews(){
        var width:CGFloat = self.frame.size.width
        for var index:Int = 0; index < _data!.count; index++ {
            var x = CGFloat(index) * width
            var imageView:UIImageView = UIImageView(frame: CGRectMake( x ,  0, width, self.frame.size.height-49))
            self.addSubview(imageView);
            
            var urlstring:String = _data![index] as String
            var url:NSURL = NSURL(string: urlstring)!
            imageView.setImageWithURL(url)
        }
        
        self.contentSize = CGSizeMake(width * CGFloat(_data!.count), self.frame.size.height-49-64)
    }
}