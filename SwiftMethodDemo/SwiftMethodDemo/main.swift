//
//  main.swift
//  SwiftMethodDemo
//
//  Created by sfwan on 14-8-20.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

// 方法:某些特定类型相关联的函数. 类,结构体,枚举都可以定义实例方法(Objective-C中枚举与结构体是不能定义方法的)
// 实例方法
class Counter {
    var count = 0
    func increment(){
        count++
    }
    func incrementBy(#amount: Int) {
        count += amount
    }
    func reset(){
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.incrementBy(amount: 5)
counter.reset()

class Counters {
    var count: Int = 0
    func incrementBy(#amount: Int, numberOfTimes: Int){
        count += amount * numberOfTimes
    }
}
// amount 当做局部名称, numberOfTimes当做局部又看作外部名称
let counters = Counters()
counters.incrementBy(amount:5, numberOfTimes:3)

// self 属性
/*
    func increment(){
        self.count++
    }
*/

// self 消除方法参数x和实例属性x之间的歧义
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
//        y = 2  结构体,枚举类型中不能直接修改属性
        return self.x > x
    }
}
let somePoint = Point(x:4.0,y:5.0)
if somePoint.isToTheRightOfX(1.0) {
    println("This point is to the right if the line where x == 1.0")
}

// 在实例方法中修改值类型 mutating
struct Points {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
}
var somePoints = Points(x:1.0, y:1.0)
somePoints.moveByX(2.0, y: 3.0)
println("the point is now at (\(somePoints.x), \(somePoints.y))")
// 方法定义时加上mutating关键字,这才让方法可以修改值类型的属性。

// 在变异方法中给self赋值, 变异方法能够赋给含属性self一个全新的实例
struct Pointss {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Pointss(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case Off, Low, High
    mutating func next (){
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
println(ovenLight == .High)
ovenLight.next()
println(ovenLight == .High)

// 类型方法
class SomeClass {
    class func someTypeMethod(){
        
    }
}
SomeClass.someTypeMethod()

/*
一般来说，任何未限定的方法和属性名称，将会来自于本类中另外的类型级别的方法和属性。一个类型方法可以调用本类中另一个类型方法的名称，而无需在方法名称前面加上类型名称的前缀。同样，结构体和枚举的类型方法也能够直接通过静态属性的名称访问静态属性，而不需要类型名称前缀
*/
struct LevelTracker {
    static var highestUnlockedLevel = 1 // 初始化时不可被访问
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker(currentLevel: 2)
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
// 注意当类 定义常成员属性时,要么直接初始化,要么在初始化方法 init 中 初始化
var player = Player(name: "Argyrios")
player.completedLevel(6)
println("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    println("player is now on level 6")
} else {
    println("player 6 has not yet been unlocked")
}




