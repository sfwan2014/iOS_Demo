//
//  Person.swift
//  Swift-ClassDemo
//
//  Created by shaofa on 14-6-11.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

import Foundation

class Person:NSObject,ChildDelegate{
    var _name: String?
    var _age:Int?
    var _id:String?
    
    init(name:String, age:Int, id:String){
        _name = name
        _age = age
        _id = id
    }
    
    func getAge() -> Int{
        return _age!
    }
    
    func getName() -> String{
        return _name!
    }
    func getID() -> String{
        return _id!
    }
    
    
    func feedChild(name:String!){
        println("\(_name)给\(name)喂奶")
    }
    
    func playWithChild(name:String!){
        println("\(_name)陪\(name)玩")
    }
    
    func takeShowerForChild(name:String!){
        println("\(_name)给\(name)洗澡")
    }
    
    func needFood(child:Child!)
    {
        self.feedChild(child._name)
    }
    
    func needClear(child:Child!)
    {
        self.takeShowerForChild(child._name)
    }
    
    func needFriend(child:Child!)
    {
        self.playWithChild(child._name)
    }
}

//func getAge() -> Int
//{
//    
//}
//func getName() -> String
//{
//
//}
//func getID() -> String
//{
//    
//}