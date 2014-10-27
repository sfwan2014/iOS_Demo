//
//  main.swift
//  SwiftExtensionsDemo
//
//  Created by sfwan on 14-8-29.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

// 扩展 : 向一个已有类,结构体或枚举类型添加新功能
/*
    Swift 中的扩展可以:
    1. 添加计算型属性和计算静态属性
    2. 定义实例方法和类型方法
    3. 提供新的构造器
    4. 定义下标
    5. 定义和使用新的嵌套类型
    6. 使一个已有类型符合某个接口

    语法:
    extension SomeType {

    }

    一个扩展可以扩展一个已有类型, 使其能够适配一个或多个协议.
    extension SomeType: SomeProtocol, AnotherProctocol {

    }
*/

// 计算型属性
// 扩展可以向已有类型添加计算型实例属性和计算型类型属性.
extension Double {
    var km: Double { return self * 1_000.0}
    var m: Double { return self}
    var cm: Double { return self / 100.0}
    var mm: Double { return self / 1_000.0}
    var ft: Double { return self / 3.28084}
}
let oneInch = 25.4.mm
println("One inch is \(oneInch) meters")
let threeFeet = 3.ft
println("Three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
println("A marathon is \(aMarathon) meters long")

// 构造器
// 扩展可以向已有类型添加新的构造器.
/*
    注意：如果你使用扩展向一个值类型添加一个构造器，该构造器向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers），那么对于来自你的扩展构造器中的值类型，你可以调用默认构造器(default initializers)和成员级构造器(memberwise initializers)。 正如在值类型的构造器授权中描述的，如果你已经把构造器写成值类型原始实现的一部分，上述规则不再适用。
*/
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size:size)
    }
}

// 方法
// 扩展可以向已有类型添加新的实例方法和类型方法
extension Int {
    func repetitions(task: () -> ()) {
        for i in 0...self {
            task()
        }
    }
}
3.repetitions { () -> () in
    println("hello")
}
3.repetitions{
    println("hehe")
}

// 修改实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
println(someInt)

// 下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
    }
}
println(746381295[2])

// 嵌套类型
extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
            }
    }
}

/*
该例子向Character添加了新的嵌套枚举。这个名为Kind的枚举表示特定字符的类型。具体来说，就是表示一个标准的拉丁脚本中的字符是元音还是辅音（不考虑口语和地方变种），或者是其它类型。

这个类子还向Character添加了一个新的计算实例属性，即kind，用来返回合适的Kind枚举成员。

现在，这个嵌套枚举可以和一个Character值联合使用了：
*/
func printLetterKinds(word: String) {
    println("'\\(word)' is made up of the following kinds of letters:")
    for character in word {
        switch character.kind {
        case .Vowel:
            print("vowel ")
        case .Consonant:
            print("consonant ")
        case .Other:
            print("other ")
        }
    }
    print("\n")
}
printLetterKinds("Hello")
// 'Hello' is made up of the following kinds of letters:
// consonant vowel consonant consonant vowel
/*
函数printLetterKinds的输入是一个String值并对其字符进行迭代。在每次迭代过程中，考虑当前字符的kind计算属性，并打印出合适的类别描述。所以printLetterKinds就可以用来打印一个完整单词中所有字母的类型，正如上述单词"hello"所展示的。

注意：由于已知character.kind是Character.Kind型，所以Character.Kind中的所有成员值都可以使用switch语句里的形式简写，比如使用 .Vowel代替Character.Kind.Vowel
*/













