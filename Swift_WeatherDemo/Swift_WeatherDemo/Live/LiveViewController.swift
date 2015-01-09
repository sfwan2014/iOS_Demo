//
//  LiveViewController.swift
//  Swift_WeatherDemo
//
//  Created by sfwan on 14-11-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit

class LiveViewController: BaseViewController {
@IBOutlet weak var scrollView: PullScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.data = ["http://h.hiphotos.baidu.com/image/w%3D2048/sign=e3f4ee0c96eef01f4d141fc5d4c69825/94cad1c8a786c91728450551cb3d70cf3bc75717.jpg", "http://b.hiphotos.baidu.com/image/w%3D2048/sign=cd95924738292df597c3ab1588095d60/a686c9177f3e67099046129739c79f3df8dc5517.jpg", "http://c.hiphotos.baidu.com/image/w%3D2048/sign=aa6458712ff5e0feee188e01685835a8/c8177f3e6709c93d2ab4599f9d3df8dcd1005417.jpg"]
        scrollView.reloadData();
    }
}
