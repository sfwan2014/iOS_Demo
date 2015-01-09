//
//  WeekForecastView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class WeekForecastView: MDXibView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        _initViews();
    }
    
    func _initViews(){
        let nib:UINib? = UINib.init(nibName: "WeekForecastCell", bundle : nil);
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "collec_cell");
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("collec_cell", forIndexPath: indexPath) as UICollectionViewCell
        
        return cell;
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(80, 100);
    }
}
