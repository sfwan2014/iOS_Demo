//
//  ViewController.swift
//  SwiftCircleLayoutDemo
//
//  Created by sfwan on 14-9-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit
extension ViewController {
    var cellCount: Int {
        get {
            return self.cellCount
        }
        set(newValue){
            self.cellCount = newValue
        }
    }
}

class ViewController: UICollectionViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cellCount = 20
        var tap = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture(:)"))
        self.collectionView! .addGestureRecognizer(tap)
        self.collectionView .registerClass(Cell.classForCoder(), forCellWithReuseIdentifier: "CellId")
        self.collectionView!.reloadData()
        self.collectionView!.backgroundColor = UIColor.grayColor()
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.cellCount
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell: AnyObject! = collectionView.dequeueReusableCellWithReuseIdentifier("CellId", forIndexPath: indexPath)
        return cell as UICollectionViewCell
    }
    
    func handleTapGesture(tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizerState.Ended {
            var initialPinchPoint: CGPoint = tap.locationInView(self.collectionView)
            var tappedCellPath: NSIndexPath = self.collectionView!.indexPathForItemAtPoint(initialPinchPoint)
            if tappedCellPath != nil {
                self.cellCount = self.cellCount - 1
                self.collectionView.performBatchUpdates({ () -> Void in
                    self.collectionView!.deleteItemsAtIndexPaths([tappedCellPath])
                }, completion: nil)
            }
        } else {
            self.cellCount = self.cellCount + 1
            self.collectionView.performBatchUpdates({ () -> Void in
                self.collectionView!.insertItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
                }, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

