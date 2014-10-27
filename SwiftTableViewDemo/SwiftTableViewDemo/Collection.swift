//
//  Collection.swift
//  SwiftTableViewDemo
//
//  Created by sfwan on 14-8-29.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class Collection: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
//        self.registerClass(CollectionViewCell().classForCoder, forCellWithReuseIdentifier: "CellId")
        self.registerNib(UINib(nibName: "CollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "CellId")

    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellId", forIndexPath: indexPath) as UICollectionViewCell
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView!, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout!, newLayout toLayout: UICollectionViewLayout!) -> UICollectionViewTransitionLayout!
//    {
//        var layout: UICollectionViewTransitionLayout?
//        layout = UICollectionViewTransitionLayout()
//        return layout
//    }
}
