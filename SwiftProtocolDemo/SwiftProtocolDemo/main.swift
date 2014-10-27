//
//  main.swift
//  SwiftProtocolDemo
//
//  Created by sfwan on 14-9-1.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation
/*
    Protocol 用于统一方法和属性的名称,而不实现任何功能,协议能够被类,枚举,结构体实现,满足协议要求的类,枚举,结构体被称为协议的遵循者
    //协议语法
    protocol SomeProtocol {
    }
*/

// 在结构体,枚举的名称后加上协议名称,中间以冒号: 分隔即可实现协议; 实现对个协议时, 个协议之间用逗号, 分隔
/*
struct SomeStructure: FirstProtocol, AnotherProtocol {

}
*/
// 属性要求
/*
    协议能够要求其遵循者必须含有一些特定名称和类型的实力属性或类属性, 也能够要求属性的设置权限和访问权限, 但它不要求属性是存储属性还是计算型属性
    通常设置var 关键字将属性声明为变量. 在属性声明后写上{get set}表示属性为可读写的. {get} 用来表示属性为可读的, 即使你为可读属性实现了setter方法,也不会出错
*/
protocol SomeProtocol {
    var musBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
}
// 用类来实现协议时,使用class关键字来表示属性为类成员; 用结构体或枚举实现协议时, 则使用static关键字来表示
protocol AnotherProtocol {
    class var someTypeProperty: Int {get set}
}
protocol FullyNamed {
    var fullName: String {get}
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
class Starship:FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: nil)
println(ncc1701.fullName)

// 方法要求 协议方法支持变长参数,不支持默认参数
/*
protocol SomeProtocol {
    class func someTypeMethod
}
*/

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
println("Here's a random number: \(generator.random())")
println("And another one: \(generator.random())")

// 突变方法要求
/*
能在方法或函数内部改变实例类型的方法称为突变方法。在值类型(Value Type)(译者注：特指结构体和枚举)中的的函数前缀加上mutating关键字来表示该函数允许改变该实例和其属性的类型。 这一变换过程在实例方法(Instance Methods)章节中有详细描述。

注意：用class实现协议中的mutating方法时，不用写mutating关键字；用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
*/

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

// 协议类型, 协议本身不实现任何功能, 但你可以将它当做类型来使用
/*
    使用场景
    1. 作为函数, 方法或构造器中的参数类型, 返回值类型
    2. 作为常量, 变量, 属性的类型
    3. 作为数组, 字典或其他容器中的元素类型

    注意: 协议类型应与其他类型(Int, Double, String)的写法相同, 使用驼峰式
 */
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    println("Random dice roll is \(d6.roll())")
}

// 委托(代理)模式
protocol DiceGame {
    var dice: Dice {get}
    func play()
}
protocol DiceGamedelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dic = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    var dice: Dice {
        return dic
    }
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue:0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGamedelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
















