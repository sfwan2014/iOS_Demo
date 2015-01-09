//
//  WeekTopAndLowView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-8.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class WeekTopAndLowView: MDXibView {
    @IBOutlet weak var topView: WeekTopCollectionView!

    @IBOutlet weak var bottomView: WeekTopCollectionView!
    
    @IBOutlet weak var dayTempView: TempView!
    @IBOutlet weak var nightTempView: TempView!
    override func awakeFromNib() {
        topView.isTop = true;
        bottomView.isTop = false;
        dayTempView.isTop = true;
        dayTempView.data = [10,11,9,12,8,13]
        nightTempView.isTop = false;
        nightTempView.data = [10,11,9,12,8,13];
    }

}
