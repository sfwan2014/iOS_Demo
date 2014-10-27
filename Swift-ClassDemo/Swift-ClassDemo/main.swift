//
//  main.swift
//  Swift-ClassDemo
//
//  Created by shaofa on 14-6-10.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

import Foundation

//var falsevar = 1
//
//struct Resolution{
//    var width = 0;
//    var height = 0;
//}
//
//class VideoMode{
//    var resolution = Resolution(width:1, height:3)
//    var interlanced = falsevar
//    var frameRate = 0.0
//    
//    var name: String?
//}
//
//enum CompassPoint{
//    case North, South, East, West
//}
//
//var video = VideoMode()
//println("\(video)")
//video.name = "jack"
//println("width = \(video.resolution.width)")
//println("name = \(video.name)")
//
//var currentDirection = CompassPoint.West
//let rememberedDirection = currentDirection
//currentDirection = .South
//if rememberedDirection == .West{
//    println("this is west direction")
//}


var p = Person(name:"jack",age:17,id:"201009882212")

println("\(p.getName())")
println("\(p.getAge())")
println("\(p.getID())")

var child = Child(name:"rose", age:2)
child._delegate = p

println("-----------")
child.childAction(ChildActionType.ChildActionTypeCry)
println("-----------")
child.childAction(ChildActionType.ChildActionTypeDirty)
println("-----------")
child.childAction(ChildActionType.ChildActionTypeSingle)

