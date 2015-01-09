//
//  UIImageView+URL.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-12-9.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageWithURL(url:NSURL){
        var request:NSURLRequest = NSURLRequest(URL: url)
        var queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { (response, data, error) -> Void in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                var image:UIImage = UIImage(data: data!)!
                self.image = image
            })
        })
    }
}
