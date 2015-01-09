//
//  WeekTopCollectionView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-8.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class WeekTopCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var _isTop:Bool = false
    var isTop:Bool{
        get{
            return _isTop;
        }
        
        set{
            _isTop = newValue
            self.registerCellWithNib()
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        self.dataSource = self;
        self.delegate = self;
    }
    
    func registerCellWithNib() {
        var nib:UINib?
        var nibName:String?
        if self.isTop {
            nibName = "WeekTopCell"
        } else {
            nibName = "WeekBottomCell"
        }
        nib = UINib(nibName:nibName!, bundle: nil)
        self.registerNib(nib!, forCellWithReuseIdentifier: "cellId")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 6;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        if self.isTop {
            let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as UICollectionViewCell
            
            return cell;
        } else {
            let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as UICollectionViewCell
            
            return cell;
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(self.frame.size.width/6, 60);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0;
    }
    
}
