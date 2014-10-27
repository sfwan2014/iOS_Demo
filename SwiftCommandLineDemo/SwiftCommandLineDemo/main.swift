//
//  main.swift
//  SwiftCommandLineDemo
//
//  Created by sfwan on 14-7-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

println("Hello, World!")

var shoppingList:String[] = ["ege", "neda"]

println("the shopping list contains \(shoppingList.count) items")
// 在数组后添加新的数据项
shoppingList.append("Flour")
// 用 += 运算符直接在数组后添加数据项
shoppingList += "Baking Powder"
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// 访问数组中的元素
var firstItem = shoppingList[0]
println(firstItem)
// 修改已有索引值对应的数据值
shoppingList[0] = "Six eggs"
//修改指定范围的数组的元素
shoppingList[4...6] = ["Bananas", "Apples"]
// 在某个具体索引值之前插入元素
shoppingList.insert("Maole Syrup", atIndex:0)

// 移除某一项
let mapleSyrup = shoppingList.removeAtIndex(0)
println(mapleSyrup)
// 移除最后一项
let apples = shoppingList.removeLast()
// 遍历数组 for - in 循环遍历
for item in shoppingList{
    println(item)
}
// 如果需要每个数据项的值和索引值,可以使用全局enumerate函数来进行数组遍历
for (index, value) in enumerate(shoppingList){
    println("Item \(index + 1): \(value)")
}

//创建并且构造一个数组
var someItem = Int[]()
someItem.append(3)
someItem = []

var threeDoubles = Double[](count:3, repeatedValue:0.0)
println(threeDoubles)// [0.0, 0.0, 0.0]

var anotherThreeDouble = Double[](count:3, repeatedValue:2.5)
var sixDoubles = threeDoubles + anotherThreeDouble
// [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]


// 字典  Dictionary<KeyType, ValueType>
var airports:Dictionary<String, String> = ["TYO": "Tokyo", "DUB": "Dublin"]
// 也可以这样: var airports = ["TYO": "Tokyo", "DUB": "Dublin"]

// 读取和修改字典
println("the dictionary of airports contains \(airports.count) items")

// 添加新的数据项
airports["LHR"] = "London"
// 修改指定键对应的值
airports["LHR"] = "London Heathrow"

// 更新修改后的值,返回旧值
let oldValue = airports.updateValue("Dublin Internation", forKey:"DUB")
if oldValue {
    println("the old value for DUB was \(oldValue).")
}

// 使用下标语法在字典中检索特定键对应的值
if let airportName = airports["DUB"] {
    println("the name of the airport is \(airportName)")
} else {
    println("that airport is not in the airports dictionary")
}

// 使用下标语法通过给某个键的对应值赋值为nil来从字典移除一个键值对
airports["APL"] = "Apple Internation"
airports["APL"] = nil

// removeValueForKey 方法用来移除字典中的键值对, 返回值为被移除的value, 或者nil
let removedValue = airports.removeValueForKey("DUB")
if removedValue {
    println("The removed airport's name is \(removedValue).")
} else {
    println("The airport dictionary does not contain a value for DUB.")
}

// 字典遍历
for (ariportCode, airportName) in airports{
    println("\(ariportCode): \(airportName)")
}

// 遍历字典的value
for airportName in airports.values {
    println(airportName)
}

// 遍历字典的key
for airportCode in airports.keys {
    println(airportCode)
}

let array = Array(airports.values)
println(array)
// 创建空字典
var namesOfIntegers = Dictionary<Int, String>()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

// 可变集合与不可变集合 var 修饰的是可变集合  let 修饰的是不可变集合

// 函数定义 与调用
func sayHello(personName:String) -> String{
    let greeting = "hello " + personName + "!"
    return greeting
}

println(sayHello("Anna"))
println(sayHello("Jhon"))

// 多输入形参
func halfOpenRangeLength(start:Int, end:Int) -> Int{
    return end - start
}
println(halfOpenRangeLength(1, 10))

// 无形参函数
func sayHello()->String{
    return "hello world"
}
println(sayHello())

// 无返回值的函数
func sayGoodbye(personName: String){
    println("Goodbye \(personName)")
}
sayGoodbye("Dave")

func printAndCount(stringToPrint: String) -> Int{
    println(stringToPrint)
    return countElements(stringToPrint)
}

func printWithCounting(stringToPrint: String) {
    printAndCount(stringToPrint)
}
printAndCount("hello world")
printWithCounting("hello world")

// 多返回值函数
func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    var vowels = 0, consonants = 0, others = 0
    for character in string {
        switch String(character).lowercaseString{
            case "a", "e", "i", "o", "u":
            ++vowels
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m","n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                ++consonants
        default:
            ++others
        }
    }
    
    return (vowels, consonants, others)
}

let total = count("some arbitrary string !")
println("\(total.vowels)")

// 函数形参名
// 外部形参名
func someFunction(外部形参名 本地形参名: Int){

}

someFunction(外部形参名: 1)

// 无外部形参名
func join(s1:String, s2:String, joiner:String) -> String {
    return s1 + joiner + s2
}
join("hello", "world", ",")

// 加入外部形参名
func join(string s1: String, toString s2: String, withJoiner joiner: String) -> String{
    return s1 + joiner + s2
}

join(string: "hello", toString: "world", withJoiner: ",")

// 外部参数名称速记
// 用一个hash符号（＃）作为名称的前缀,告诉Swift使用名称相同的本地行参名称和外部形参名称
func containsCharacter(#string: String, #characterToFind: Character) -> Bool {
    for character in string {
        if character == characterToFind {
            return true
        }
    }
    
    return false
}

let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")
println(containsAVee)

// 默认形参值
func joins(#string: String, #toString: String, withJoiner joiner: String = " ") -> String{
    return string + joiner + toString
}

println(joins(string: "hello", toString: "world", withJoiner: "-"))
// 默认使用单个空格
println(joins(string: "hello", toString: "world"))

// 有默认值的外部形参名
func joinss(string: String, toString: String, joiner: String = " ") -> String{
    return string + joiner + toString
}
// 默认形参必须有外部形参名
println(joinss("hello", "world", joiner: "_"))

// 可变形参
// (...)
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers{
        total += number
    }
    
    return total
}
println(arithmeticMean(1,2,3,4,5,6))

// 常量形参和变量形参
// 函数的形参默认是常量
// 在参数名称前用关键字var定义变量
func alignRight(var #string: String, #count: Int, #pad: Character) -> String {
    let amountToPad = count - countElements(string)
    for _ in 1...amountToPad {
        string = pad + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(string: originalString, count: 10, pad: "-")
println(paddedString)

// In-Out形参
// In-Out参数不能有默认值,可变参数的参数也不能被标记为In-Out,同时当参数被标记为var 或 let 时也不能被标记为In-Out
func swapTwoInts(inout a: Int, inout b: Int) {
    let temp = a
    a = b
    b = temp
}
var a = 10, b = 5
swapTwoInts(&a, &b)
println("a= \(a), b = \(b)")

// 函数类型
// 每一个函数都有特定的函数类型, 由函数的形参类型和返回类型组成
func addTwoInts(a: Int, b: Int) -> Int {
    return a+b
}
// 函数类型为 (Int, Int)->Int

// 使用函数类型
// 定义一个函数类型,并为变量指定一个对应的函数
var mathFunction:(Int, Int)->Int = addTwoInts
println("result: \(mathFunction(3, 5))")

// 相同函数类型的不同函数,也可以用同一个函数变量
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}
mathFunction = multiplyTwoInts
println("result: \(mathFunction(3, 5))")

// 作为形参类型的函数类型
func printMathResult(mathFunction: (Int, Int)->Int, a: Int, b: Int){
    println("result: \(mathFunction(a,b))")
}
printMathResult(multiplyTwoInts, 5, 8)

// 作为返回类型的函数类型
func stepForward(input: Int) -> Int{
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards: Bool) -> (Int)->Int{
    return backwards ? stepBackward:stepForward
}

var currentValue = 3
let moveNearToZero = chooseStepFunction(currentValue > 0)
println("Counting to zero")
while currentValue != 0 {
    println("\(currentValue)...")
    currentValue = moveNearToZero(currentValue)
}
println("zero")

// 嵌套函数
func chooseStepFunctions(backwards: Bool) -> (Int)->Int{
    func stepForward(input: Int) -> Int{
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    return backwards ? stepBackward : stepForward
}

var currentValues = -4
let moveNearToZeros = chooseStepFunctions(currentValues > 0)
while currentValues != 0 {
    println("\(currentValues)...")
    currentValues = moveNearToZeros(currentValues)
}
println("zero")


// 控制流
// For 循环
// For-In
for index in 1...6{
    println(index)
}

// 如果不需要知道范围内每一项的值, 可以使用"_"替代变量index,忽略对值的访问
let base = 3
let power = 10
var answer = 1
for _ in 1...power{
    answer *= base
}
println(answer)

// 使用for-in 遍历一个数组所有元素
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    println("Hello, \(name)")
}
// 遍历字典的键值对
let numberOfLegs = ["spider":8, "ant":6, "cat":4]
for (animalName, legCount) in numberOfLegs{
    println("\(animalName)s have \(legCount) legs")
}
// 遍历字符串中的字符
for character in "hello"{
    println(character)
}
// For 条件递增(for-condition-increment)
// 标准c样式for 循环(括号可以可无)
for var i = 0; i < 3; i++ {
    println("index is \(i)")
}

// While 循环
let finalSquare = 25
var board  = Int[](count: finalSquare+1, repeatedValue: 0)
var square = 0
var diceRoll = 0
while square < finalSquare{
    if ++diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}

println("game over")


// Switch 语句
/*
switch 'some value to consider' {
    case 'value 1':
            'respond to value 1'
    case 'value 2', 'value 3':
            'respond to value 2 or 3'
    default 'otherwise, do something else'
}
*/

let someCharacter: Character = "e"
switch someCharacter {
    case "a", "e", "i", "o", "u":
        println("\(someCharacter) is a vowel")
    case  "b", "c", "d", "f", "g", "h", "j",
            "k", "l", "m","n", "p", "q", "r",
            "s", "t", "v", "w", "x", "y", "z":
        println("\(someCharacter) is a consonant")
    default:
        println("\(someCharacter) is not a vowel or consonant")
}
// siwtch 语句不存在隐式的贯穿

// 元组
let somePoint = (1,1)
switch somePoint {
case (0,1) :
    println("(0,0) is at the origin")
case (_, 0):
    println("(\(somePoint.0), 0) is at the x-axis")
case (0, _) :
    println("(0, \(somePoint.1)) is at the y-axis")
case (-2...2, -2...2):
    println("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    println("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

// 值绑定
let anotherPoint = (2, 2)
switch anotherPoint {
case (let x, 0):
    println("on the x-axis with a x value of \(x)")
case (0, let y) :
    println("on the y-axis with a x value of \(y)")
case (let x, let y) :
    println("somewhere else at \(x), \(y)")
}

// where, case 块的模式可以使用where语句来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    println("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    println("(\(x), \(y)) is on the line x == -y")
case let (x, y) :
    println("(\(x), \(y)) is just some arbitrary point")
}
//NOTE：当一个switch分支仅仅包含注释时，会被报编译时错误。注释不是代码语句而且也不能让switch分支达到被忽略的效果。你总是可以使用break来忽略某个分支。

// Fallthrough, swift 语言中switch语句不存在隐式贯穿, 若是需要贯穿时,则在case 块后加上 fallthrough 关键字标记
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is "
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += "a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
println(description)



/*******************7. 闭包********************/
// sort 函数
let nameArray = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func exbackwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversed = sort(nameArray, exbackwards)
println(reversed)

/*
 *  闭包表达式语法
 *  { (parameters) -> returnType in
 *      statements
 *  }
 */
// 展开之后
reversed = sort(nameArray, {(s1: String, s2: String) -> Bool in
    return s1 < s2
})
println(reversed)
// 闭包的函数体部分由关键字in引入, 改关键字表示闭包的参数和返回值类型定义已经完成, 闭包函数体即将开始

// 根据上下文推断类型
reversed = sort(nameArray, {s1, s2 in return s1 > s2})
//单行表达式闭包可以省略 return
reversed = sort (nameArray, {s1, s2 in s1 > s2})
// 参数名简写swift自动为内联函数提供参数名称简写功能, 可以直接通过$0, $1, $2等名字来引用的闭包的参数值
reversed = sort(nameArray, {$0 > $1})
// $0 和 $1 表示闭包中第一个和第二个String类型参数

// 运算符函数 
reversed = sort(nameArray, >)

// Trailing 闭包, 如果要将一个很长的闭包表达式作为最后一个参数传递给函数, 可以使用trailing闭包来增强函数的可读性
func someFunctionThatAClosure(closure: () -> ()){
    
}
// 不使用trailing闭包进行函数调用
someFunctionThatAClosure({
})
// 使用trailing
//someFunctionThatAClosure(){} //也可以
someFunctionThatAClosure{}

// 上例作为sort 函数参数的字符串排序闭包可以改写为:
reversed = sort(nameArray){$0 > $1}

// 捕获



/*****************************枚举*******************************/

// 枚举语法
enum SomeEnumeration{
    // 枚举数据
}

enum CompassPoint{
    case North
    case South
    case East
    case West
}

println(CompassPoint.North)
// 多个成员值可以出现在同一行,逗号隔开
enum Plant{
    case Mercury, Venus, Earth, Mars, Jupiter, Staturn, Uranus, Nepturn
}
var directionToHead = CompassPoint.West
directionToHead = .East

// 匹配枚举值和switch语句
// 可以匹配单个枚举值和switch语句
directionToHead = .South
switch directionToHead {
case .North:
    println("Lots of planets have north")
case .South:
    println("watch out for penguins")
case .East:
    println("where the sun rises")
case .West:
    println("where the skies are blue")
}

// 关联值
enum Barcode{
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909_51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMN")

// 与switch 语句混用
switch productBarcode {
case .UPCA(let numberSystem, let identifier, let check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check)")
case .QRCode(let productCode):
    println("QR code with value of \(productCode)")
}

switch productBarcode {
case let .UPCA(numberSystem, identifier, check):
    println("UPC-A with value of \(numberSystem), \(identifier), \(check).")
case let .QRCode(productCode):
    println("QR code with value of \(productCode).")
}

// 原始值 枚举成员设置默认值,即为原始值
enum ASIIControlCharacter: Character{
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

enum Plants: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
// 以此类推 Plants.Venus = 2
// 使用枚举成员的toRaw方法可以访问原始值
let earthOrder = Plants.Earth.toRaw()
println(earthOrder)
// 使用枚举的fromRaw方法来找到具有特定原始值的枚举成员
let possiblePlant = Plants.fromRaw(4)

let positionToFind = 9
if let somePlanet = Plants.fromRaw(positionToFind) {
    switch somePlanet {
    case .Earth:
        println("Mostly harmless")
    default:
        println("not a safe place for humans")
    }
} else {
    println("there isn't a planet at position \(positionToFind)")
}









