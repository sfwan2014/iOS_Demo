//
//  HeadView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class HeadView: MDXibView {
    
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var hourBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImage.highlightedImage = UIImage.init(named: "forecast_minicard_24h_icon_arrowdown");
        arrowImage.image = UIImage.init(named: "forecast_minicard_24h_icon_arrowup");
    }
    override func layoutSubviews() {
        hourBtn.selected = self.open!;
        arrowImage.highlighted = self.open!;
    }
    
    @IBAction func showDayForecastAction(sender: UIButton) {
        
        sender.selected = !sender.selected;
        println(sender.selected);
        arrowImage.highlighted = sender.selected;
        someClosure(sender.selected,"s");
    }
}



