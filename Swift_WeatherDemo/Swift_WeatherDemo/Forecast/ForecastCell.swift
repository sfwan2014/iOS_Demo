//
//  ForecastCell.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    var _open:Bool = false
    var open:Bool{
        get {
            return _open
        }
        set{
            _open = newValue;
        }
    }
    
    var _viewName: String?
    var row:Int?
    var section:Int?
    var indexPath:NSIndexPath?{
        get{
            return NSIndexPath.init(forRow: row!, inSection : section!)
        }
        set{
            row = newValue?.row;
            section = newValue?.section;
            _reSetSubViews();
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.contentView.backgroundColor = UIColor.clearColor();
        self.backgroundColor = UIColor.clearColor();
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.layer.masksToBounds = true;
    }
    
    func _initViews(){
        var view:MDXibView = MDXibView.loadViewFromNib(_viewName?) as MDXibView;
        view.someClosure = someClosure;
        view.open = self.open;
        self.contentView.addSubview(view);
    }
    
    func _reSetSubViews(){
        for view in self.contentView.subviews {
            if (view.isKindOfClass(MDXibView.classForCoder())){
                view.removeFromSuperview();
            }
        }
        let row:Int = indexPath!.row
        switch row {
        case 0:
            self._viewName = "HeadView"
        case 1:
            self._viewName = "DayForecastView"
        case 2:
            self._viewName = "WeekForecastView"
        case 3:
            self._viewName = "WeekTopAndLowView"
        case 4:
            self._viewName = "LifeView"
        case 5:
            self._viewName = "HeadView"
        default: 
            self._viewName = "HeadView"
        }
        _initViews();
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 