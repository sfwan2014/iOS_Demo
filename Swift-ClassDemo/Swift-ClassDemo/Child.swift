//
//  Child.swift
//  Swift-ClassDemo
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

import Foundation

enum ChildActionType : Int {
    case ChildActionTypeCry
    case ChildActionTypeDirty
    case ChildActionTypeSingle
}

protocol ChildDelegate {
    func needFood(child:Child!)
    func needClear(child:Child!)
    func needFriend(child:Child!)
}

class Child{
    var _age:Int?
    var _name:String?
    var _delegate:ChildDelegate!
    var _time:Int?
    init(name:String,age:Int){
        _name = name
        _age = age
    }
    
    func childAction(actionType:ChildActionType!){
        if actionType == ChildActionType.ChildActionTypeCry {
            println("\(_name) cry")
            _delegate.needFood(self)
        } else if actionType == ChildActionType.ChildActionTypeDirty {
            println("\(_name) dirty")
            _delegate.needClear(self)
        } else if actionType == ChildActionType.ChildActionTypeSingle{
            println("\(_name) lonely")
            _delegate.needFriend(self)
        }
    }
}


