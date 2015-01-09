//
//  TempView.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-8.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class TempView: UIView {

    var _points:NSArray?
    var _data:NSArray?
    var data:NSArray{
        get{
            return _data!
        }
        set{
            _data = newValue;
            self.setNeedsDisplay()
        }
    }
    
    var _isTop:Bool = false
    var isTop:Bool {
        get{
            return _isTop;
        }
        
        set{
            _isTop = newValue;
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context:CGContextRef = UIGraphicsGetCurrentContext()
        if self.isTop {
            self.drawUpper(context)
        } else {
            self.drawLower(context)
        }
    }

    func drawUpper(context:CGContextRef){
        
        _points = self.pointFromData();
        CGContextSaveGState(context)
        CGContextSetStrokeColorWithColor(context, UIColor.cyanColor().CGColor)
        self.drawLine(context)
        CGContextRestoreGState(context)
        
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, UIColor.orangeColor().CGColor);
        
        for var index=0; index < _points!.count; index++ {
            var obj:NSValue = _points![index] as NSValue
            var point:CGPoint = obj.CGPointValue()
            self.drawPoint(context, point: point)
        }
        CGContextRestoreGState(context)
    }
    
    func drawLower(context:CGContextRef){
        
        _points = self.pointFromData();
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, UIColor.cyanColor().CGColor);
        self.drawLine(context)
        CGContextRestoreGState(context)
        
        CGContextSaveGState(context)
        CGContextSetFillColorWithColor(context, UIColor.purpleColor().CGColor);
        
        for var index=0; index < _points!.count; index++ {
            var obj:NSValue = _points![index] as NSValue
            var point:CGPoint = obj.CGPointValue()
            self.drawPoint(context, point: point)
        }
        CGContextRestoreGState(context)
    }
    
    func drawPoint(context:CGContextRef, point:CGPoint){
        CGContextSetShouldAntialias(context, true ); //抗锯齿
        var Pointcolorspace1:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGContextSetStrokeColorSpace(context, Pointcolorspace1);
        CGContextMoveToPoint(context, point.x,point.y);
        
        var pointRadius:CGFloat = 5;
        
        CGContextAddArc(context, point.x, point.y, pointRadius, 0, 360, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
    
    func drawLine(context:CGContextRef){
        var p:Array = Array(count:_points!.count, repeatedValue: CGPoint());
        for var index:Int=0; index < _points!.count; index++ {
            var obj:NSValue = _points![index] as NSValue
            var point:CGPoint = obj.CGPointValue()
            p[index] = point;
        }
        
        CGContextMoveToPoint(context, p[0].x, p[0].y)
        CGContextAddLines(context, p, UInt(_points!.count))
        CGContextStrokePath(context)
    }
    
    func pointFromData()->NSArray{
        if _data?.count < 2 {
            return NSArray();
        }
        var points:NSMutableArray = NSMutableArray()
        var origin:NSInteger = _data![1].integerValue;
        var left = self.frame.size.width/12
        var horizontal:CGFloat = self.frame.size.height/2
        
        for var index:Int = 0; index < _data!.count; index++ {
            var obj:NSNumber = _data![index] as NSNumber
            var intNum:Int = obj.integerValue
            var cha:Int = intNum - origin
            var y:CGFloat = horizontal
            y = horizontal + CGFloat(cha) * 5
            
            var p:CGPoint = CGPointMake(left + (CGFloat(index)) * 2 * left, y);
            points.addObject(NSValue(CGPoint: p));
        }
        
        return points
    }
}
