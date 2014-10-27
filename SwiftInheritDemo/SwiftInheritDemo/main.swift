//
//  main.swift
//  SwiftInheritDemo
//
//  Created by sfwan on 14-8-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//
// ┏ ┓　　　┏ ┓
//┏┛ ┻━━━━━┛ ┻┓
//┃　　　　　　 ┃
//┃　　　━　　　┃
//┃　┳┛　  ┗┳　┃
//┃　　　　　　 ┃
//┃　　　┻　　　┃
//┃　　　　　　 ┃
//┗━┓　　　┏━━━┛
//  ┃　　　┃   神兽保佑
//  ┃　　　┃   代码无BUG！
//  ┃　　　┗━━━━━━━━━┓
//  ┃　　　　　　　    ┣┓
//  ┃　　　　         ┏┛
//  ┗━┓ ┓ ┏━━━┳ ┓ ┏━┛
//    ┃ ┫ ┫   ┃ ┫ ┫
//    ┗━┻━┛   ┗━┻━┛
//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         ………………………………………
//                  佛祖镇楼                  BUG辟易

import Foundation
/*
在 Swift 中，类可以调用和访问超类的方法，属性和附属脚本（subscripts），并且可以重写（override）这些方法，属性和附属脚本来优化或修改它们的行为。Swift 会检查你的重写定义在超类中是否有匹配的定义，以此确保你的重写行为是正确的。
*/
class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
    init(){
        numberOfWheels = 0
        maxPassengers = 1
    }
}
let someVehicle = Vehicle()

// 子类生成
class Bicycle: Vehicle {
    init(){
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
println(bicycle.description())

class Tandem: Bicycle {
    init(){
        super.init()
        maxPassengers = 2
    }
}

let tandem = Tandem()
println(tandem.description())

// 重写  重写某个特性，需要在重写定义的前面加上override关键字
/*
在方法someMethod的重写实现中，可以通过super.someMethod()来调用超类版本的someMethod方法。
在属性someProperty的 getter 或 setter 的重写实现中，可以通过super.someProperty来访问超类版本的someProperty属性。
在附属脚本的重写实现中，可以通过super[someIndex]来访问超类版本中的相同附属脚本。
*/

// 重写方法
class Car: Vehicle {
    var speed: Double = 0.0
    init() {
        super.init()
        maxPassengers = 5
        numberOfWheels = 4
    }
    override func description() -> String{
        return super.description() + ";" + "traveling at \(speed) mph"
    }
}
let car = Car()
println(car.description())

// 重写属性的Getters和Setters
class SpeedLimitedCar: Car {
    @final func cannotOverride(){
        
    }
    override var speed: Double {
    get {
        return super.speed
    }
    set {
        super.speed = min(newValue, 40.0)
    }
    }
}
let limitedCar = SpeedLimitedCar()
limitedCar.speed = 60.0
println("SpeedLimitedCar: \(limitedCar.description())")

// 重写属性观察器
class AutomaticCar: Car {
    var gear = 1
    override var speed: Double {
    didSet {
        gear = Int(speed / 10.0) + 1
    }
    }
    override func description() -> String {
        return super.description() + "in gear \(gear)"
    }
    
//    override func cannotOverride(){// 不能重写
//        
//    }
}
let automatic = AutomaticCar()
automatic.speed = 35.0
println(automatic.description())

// 防止重写
/*
可以通过把方法，属性或附属脚本标记为final来防止它们被重写，只需要在声明关键字前加上@final特性即可。（例如：@final var, @final func, @final class func, 以及 @final subscript）

你可以通过在关键字class前添加@final特性（@final class）来将整个类标记为 final 的，这样的类是不可被继承的，否则会报编译错误。
*/



