//
//  CircleLayout.swift
//  SwiftCircleLayoutDemo
//
//  Created by sfwan on 14-9-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//
import UIKit
let ITEM_SIZE: CGFloat = 70.0
extension CircleLayout {
    internal
    var center: CGPoint {
        set(newValue) {
            self.center = newValue
        }
        get {
            return self.center
        }
    }
    var radius: CGFloat {
        get{
            return self.radius
        }
        set(newValue) {
            self.radius = newValue
        }
    }
    var cellCount: NSInteger {
        get{
            return self.cellCount
        }
        set(newValue) {
            self.cellCount = newValue
        }
    }
    private
    var deleteIndexPaths: NSMutableArray {
        get{
            return self.deleteIndexPaths
        }
        set(newValue) {
            self.deleteIndexPaths = newValue
        }
    }
    var insertIndexPath: NSMutableArray {
        get{
            return self.insertIndexPath
        }
        set(newValue) {
            self.insertIndexPath = newValue
        }
    }
}
class CircleLayout: UICollectionViewLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        var size: CGSize = self.collectionView.frame.size
        cellCount = self.collectionView.numberOfItemsInSection(0)
        center = CGPointMake(size.width/2.0, size.height/2.0)
        radius = CGFloat( min(size.width, size.height) / 2.5)
    }
    
    override func collectionViewContentSize() -> CGSize {
        return self.collectionView.frame.size
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath!) -> UICollectionViewLayoutAttributes! {
        var attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE)
        attributes.center = CGPointMake(center.x + radius * cosf(2 * indexPath.item * M_PI / cellCount), center.y + radius * sinf(2 * indexPath.item * M_PI / cellCount))
        return attributes
    }
}








