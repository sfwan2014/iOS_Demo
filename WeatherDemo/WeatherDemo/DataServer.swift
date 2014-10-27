//
//  DataServer.swift
//  WeatherDemo
//
//  Created by sfwan on 14-6-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import UIKit
class DataServer: NSObject {
//    let identifier = "cellId"
    class func request(var url:String?, var params:Dictionary<String,String>!, var httpMethod:String){
        
        let baseURL = "asdada"
        var urlstring:NSMutableString?
//        urlstring = NSMutableString(format:"%@/%@", baseURL?, url?)
        
        if httpMethod == "GET"{
//            urlstring.stringByAppendingFormat(format: "%@",baseURL)
        }
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: urlstring))
    }
    
}