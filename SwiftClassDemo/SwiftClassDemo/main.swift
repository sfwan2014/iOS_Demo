//
//  main.swift
//  SwiftClassDemo
//
//  Created by sfwan on 14-8-4.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

println("Hello, World!")

/*
    Swift 中类与结构体对比
    1. 共同之处
        a. 定义属性用于存储在
        b. 定义方法用于提供功能
        c. 定义下标用于通过下标语法访问值
        d. 定义初始化器用于生成初始化值
        e. 通过扩展以增加默认实现的功能
        f. 符合协议以对某类提供标准功能
    
    2. 与结构体相比, 类还具有如下功能
        a. 继承允许一个类继承另一个类的特征
        b. 类型转换允许在运行时检查和解释一个类实例的类型
        c. 取消初始化器允许一个类实例释放任何其所被分配的资源
        d. 引用计数允许对一个类的多次引用
*/

// 定义
class SomeClass{
    // 属性,方法
}
struct SomeStructure{
    // 属性
}

// 定义示例
struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 类与结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

// 属性访问
println("The width of someResolution is \(someResolution.width)")
println("The width of someVideoMode is \(someVideoMode.resolution.width)")
// 属性赋值
someVideoMode.resolution.width = 12880
println("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// 注意: 与 Objective-C 语言不同, Swift 允许直接设置结构体属性的子属性

// 结构体类型的成员逐一初始化器
let vga = Resolution(width:640, height:480)
// 与结构体不同, 类实例没有默认的成员逐一初始化器.

// 结构体和枚举是值类型, 在传递的时候都会被复制
let hd = Resolution(width:1920, height:1080)
var cinema = hd// cinema 不是hd 的本身, 是从hd复制而来的,两个不同的实例

// 类是引用类型, 与值类型不同, 引用类型在被赋值到一个变量, 常量或者传递到一个函数时, 操作的并不是其拷贝. 因此,引用的是已存在的实例本身而不是其拷贝
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty;
alsoTenEighty.frameRate = 30.0
println("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// 恒等运算符  等价于(===), 不等价于(!==)   用于判断两个实例是否为引用同一类实例
if tenEighty === alsoTenEighty {
    println("tenEighty and alsoTenEighty refer to the same Resolution instance. ")
}
// 等于 表示两个实例的值相等或相同

// 类与结构体的选择
/*
    使用类和结构体定义自定义数据类型, 然而, 结构体实例是通过值传递, 类实例是通过引用传递. 这意味着两者适用不同的任务, 
    按照通用的准则, 当符合一条或多条以下条件时, 请考虑构建结构体:
    1. 结构体的主要目的是用来封装少量简单数据值
    2. 有理由预计一个结构体实例在赋值或者传递时, 封装的数据将会被拷贝而不是被引用
    3. 任何在结构体中储存的值类型属性,也将会被拷贝,而不是被引用
    4. 结构体不需要去继承另一个已存在类型的属性或行为

    合适的结构体候选者包括:
    1. 几何形状的大小, 封装一个width属性和height属性, 两者均为Double类型
    2. 一定范围内的路径, 封装一个start属性和length属性, 两者均为Int类型
    3. 三维坐标系内一点, 封装x,y,z属性, 三者均为Double类型
*/

// 集合类型的赋值和拷贝行为
/*
    Swift 中数组(Array)和字典(Dictionary)类型均以结构体的形式实现, 然而当数组被赋予一个常量或变量, 或被传递给一个函数或方法时, 其拷贝行为与字典和其他结构体有些许不同
*/

// 字典类型的赋值和拷贝行为
/*
    如果字典实例中所储存的键(keys)和/或值(values)是值类型(结构体或枚举)，当赋值或调用发生时，它们都会被拷贝。相反，如果键(keys)和/或值(values)是引用类型，被拷贝的将会是引用，而不是被它们引用的类实例或函数。字典的键和值的拷贝行为与结构体所储存的属性的拷贝行为相同。
*/
var ages = ["Peter":23, "Wei":35, "Anish":65, "Katya":19];
var copiedAges = ages;
copiedAges["Peter"] = 30
println(ages["Peter"])// 23   说明是值传递

// 数组的赋值和拷贝行为
/*
    对数组来说，拷贝行为仅仅当操作有可能修改数组长度时才会发生。这种行为包括了附加(appending),插入(inserting),删除(removing)或者使用范围下标(ranged subscript)去替换这一范围内的元素。
*/
var a = [1, 2, 3]
var b = a
var c = a
println(a[0])
println(b[0])
println(c[0])

a[0] = 42
println(a[0])
println(b[0])
println(c[0])

println()

a.append(4) // 发生拷贝
a[0] = 77
println(a[0])
println(b[0])
println(c[0])

println()
// 确保数组的唯一性  通过在数组变量上调用unshare方法来确定数组引用的唯一性。(当数组赋给常量时，不能调用unshare方法)
b.unshare()
b[0] = -102
println(a[0])
println(b[0])
println(c[0])

// 判断两个数组是否共用相同元素
// 通过使用恒等运算符(=== and !==) 来判定两个数组或子数组共用相同的储存空间或元素
if b === c {
    println("b and c still share the same array elements")
} else {
    println("b and c now refer to two independent sets of array elements.")
}
// 判定子数组是否共用相同的元素
if b[0...2] === c[0...2] {
    println("these two subarrays share the same elements")
} else {
    println("these two subarrays do not share the elements")
}

//强制复制数组, 通过调用数组的copy方法进行强制显性复制, 这个方法对数组进行了浅拷贝, 并返回一个包含此拷贝的新数组
var names = ["Mohsen", "Hilary", "Justyn", "Amy", "Rich", "Graham", "Vic"]
var copiedNames = names.copy()
copiedNames[0] = "Mo"
println(names[0])
/*
    注意：如果你仅需要确保你对数组的引用是唯一引用，请调用unshare方法，而不是copy方法。unshare方法仅会在确有必要时才会创建数组拷贝。copy方法会在任何时候都创建一个新的拷贝，即使引用已经是唯一引用。
*/


/************************************属性*******************************/

// 存储属性
// 简单来说, 一个存储属性就是存储在特定类或结构体的实例里里的一个常量或变量, 存储属性可以是变量存储属性(var), 也可以是常量存储属性(let)
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue:0, length:3)
rangeOfThreeItems.firstValue = 6;

// 常量和存储属性
let rangeOfFourItems = FixedLengthRange(firstValue:0, length:4)
//rangeOfFourItems.firstValue = 6  尽管firstValue是个变量属性,但是还是会报错
// rangeOfFourItems 声明成了常量, 即使firstValue是一个变量属性, 也无法修改
// 这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
//属于引用类型的类（class）则不一样，把一个引用类型的实例赋给一个常量后，仍然可以修改实例的变量属性。

// 延迟存储属性, 延迟存储属性是指当第一次调用的时候才会计算其初始化值的属性. 在属性声明钱使用@lazy 类表示一个延迟存储属性 (必须把延迟存储属性声明成变量)
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    @lazy var importer = DataImporter()
    var data = String[]()
}

let manager = DataManager()
manager.data += "some data"
manager.data += "some more data"
println(manager.importer.fileName)
// 当用到 importer 时,才会去创建 importer及其属性

// 计算属性 
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get {
        let centerX = origin.x + (size.width / 2)
        let centerY = origin.y + (size.height / 2)
        return Point(x:centerX, y:centerY)
    }
    set(newCenter){
        origin.x = newCenter.x - (size.width / 2)
        origin.y = newCenter.y - (size.height / 2)
    }
    }
}
var square = Rect(origin: Point(x:0.0, y:0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
println("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// 便捷 setter 声明
// 如果计算属性的setter没有定义表示新值的参数名, 则可以使用默认名称newValue
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
    get {
        let centerX = origin.x + (size.width / 2)
        let centerY = origin.y + (size.height / 2)
        return Point(x:centerX, y:centerY)
    }
    set {
        origin.x = newValue.x - (size.width / 2)
        origin.y = newValue.y - (size.height / 2)
    }
    }
}

// 只读计算属性
// 只读计算属性的声明可以去掉get关键字和花括号
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
println("the volume of fourFiveByTwo is \(fourFiveByTwo.volume)")

// 属性监视器 willSet, didSet
class StepCounter {
    var totalSteps: Int = 0 {
    willSet(newTotalSteps) {
        println("About to set totalSteps to \(newTotalSteps)")
    }
    didSet{
        if totalSteps > oldValue {
            println("Added \(totalSteps - oldValue) steps")
        }
    }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896
// 注意：willSet和didSet监视器在属性初始化过程中不会被调用，他们只会当属性的值在初始化之外的地方被设置时被调用。

//全局变量和局部变量
// 全局变量是在函数, 方法, 闭包或任何类型之外定义的变量; 局部变量是在函数, 方法或闭包内部定义的变量
// 注意：全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记@lazy特性；局部范围的常量或变量不会延迟计算。

// 类型属性
// 实例的属性属于一个特定类型实例,每次类型实例化后都拥有自己的一套属性值, 实例之间的属性相互独立
// 类型属性语法
// 存储型和计算型属性的语法:
struct OtherStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 10
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 20
    }
}

class OtherClass {
    class var computedTypeProperty: Int {
        return 40
    }
}

// 获取和设置类型属性的值
// 跟实例的属性一样，类型属性的访问也是通过点运算符来进行，但是，类型属性是通过类型本身来获取和设置，而不是通过实例
println(OtherClass.computedTypeProperty)
println(OtherStructure.storedTypeProperty)
OtherStructure.storedTypeProperty = "Another value"
println(OtherStructure.storedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
    didSet{
        if currentLevel > AudioChannel.thresholdLevel {
            currentLevel = AudioChannel.thresholdLevel
        }
        if currentLevel > AudioChannel.maxInputLevelForAllChannels {
            AudioChannel.maxInputLevelForAllChannels = currentLevel
        }
    }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
println(leftChannel.currentLevel)
println(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
println(rightChannel.currentLevel)
println(AudioChannel.maxInputLevelForAllChannels)




