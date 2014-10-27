//
//  main.swift
//  SwiftInitializers
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
//  Created by sfwan on 14-8-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

// 构造过程
/*
构造过程是为了使用某个类、结构体或枚举类型的实例而进行的准备过程。这个过程包含了为实例中的每个属性设置初始值和为其执行必要的准备和初始化任务。
*/
// 存储型属性的初始赋值
//注意：当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观测器（property observers）。
// 构造器
struct Fahrenheit {
    var temperature: Double
    init(){
        temperature = 32.0
    }
}
var f = Fahrenheit()
println("The default temperature is \(f.temperature)")

// 定制构造化过程
// 构造参数
struct Celsius {
    var temperatureCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
println(boilingPointOfWater.temperatureCelsius)
println(freezingPointOfWater.temperatureCelsius)

/*
    构造器并不像函数和方法那样在括号前有一个可辨别的名字。所以在调用构造器时，主要通过构造
    器中的参数名和类型来确定需要调用的构造器。正因为参数如此重要，如果你在定义构造器时没有
    提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名，就
    相当于在每个构造参数之前加了一个哈希符号。

注意：如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线_来显示描述它的外部名，以此覆盖上面所说的默认行为
*/

struct Color {
    let red = 0.0, green = 0.0, blue = 0.0
    init(_ red: Double, _ green: Double, _ blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
let magenta = Color(1.0, 0.0, 1.0)

// 可选属性类型
class SurveryQuestion {
    var text: String
    var response: String?// optional 类型
    init(text: String) {
        self.text = text
    }
    func ask(){
        println(text)
    }
}
let cheeseQuestion = SurveryQuestion(text: "Do you like cheese ?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese"

// 构造过程中常量属性的修改
class SurveryQuestions {
    let text: String
    var response: String?// optional 类型
    init(text: String) {
        self.text = text
    }
    func ask(){
        println(text)
    }
}
var cheeseQuestions = SurveryQuestions(text: "Do you like beets ?")
cheeseQuestions.ask()
/*
只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值。

注意：对某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改
*/

// 默认构造器
//Swift 将为所有属性已提供默认值的且自身没有定义任何构造器的结构体或基类，提供一个默认的构造器。这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

// 结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2)

// 值类型的构造器代理
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(x: Double, y: Double, width: Double, height: Double) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let otherRect = Rect(x: 4.0, y: 4.0, width: 6.0, height: 6.0)

// 类的继承和构造过程
/*
指定构造器和便利构造器
指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。

每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节自动构造器的继承。

便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入的实例。

你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清、晰明。
*/

/** 构造器链, 为了简化指定构造器和便利构造器之间的调用关系,Swift 采用了一下三条规则来限制构造器之间的代理调用:
    规则 1:
        指定构造器必须调用其直接父类的指定构造器

    规则 2: 
        便利构造器必须调用同一类中定义的其他构造器

    规则 3:
        便利构造器必须最终以调用一个指定构造器结束
    巧记口诀:
        指定构造器必须总是向上代理
        便利构造器必须总是横向代理
    
    注意：这些规则不会影响使用时，如何用类去创建实例。任何上图中展示的构造器都可以用来完整创建对应类的实例。这些规则只在实现类的定义时有影响。


        Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程能顺利完成：

        安全检查 1
        指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。

        如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。

        安全检查 2
        指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。

        安全检查 3
        便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。

        安全检查 4
        构造器在第一阶段构造完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self的值。

        以下是两段式构造过程中基于上述安全检查的构造流程展示：

        阶段 1
        某个指定构造器或便利构造器被调用；
        完成新实例内存的分配，但此时内存还没有被初始化；
        指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化；
        指定构造器将调用父类的构造器，完成父类属性的初始化；
        这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部；
        当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段1完成。

        阶段 2
        从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
        最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。

        构造器的继承和重载
        跟 Objective-C 中的子类不同，Swift 中的子类不会默认继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误的用来创建子类的实例。

        假如你希望自定义的子类中能实现一个或多个跟父类相同的构造器--也许是为了完成一些定制的构造过程--你可以在你定制的子类中提供和重载与父类相同的构造器。

        如果你重载的构造器是一个指定构造器，你可以在子类里重载它的实现，并在自定义版本的构造器中调用父类版本的构造器。

        如果你重载的构造器是一个便利构造器，你的重载过程必须通过调用同一类中提供的其它指定构造器来实现。这一规则的详细内容请参考构造器链。

        注意：与方法、属性和下标不同，在重载构造器时你没有必要使用关键字override。

        自动构造器的继承
        如上所述，子类不会默认继承父类的构造器。但是如果特定条件可以满足，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重载父类的构造器，并且在尽可能安全的情况下以最小的代价来继承父类的构造器。

        假设要为子类中引入的任意新属性提供默认值，请遵守以下2个规则：

        规则 1
        如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。

        规则 2
        如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的，还是通过自定义实现的--它将自动继承所有父类的便利构造器。

        即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。

        注意：子类可以通过部分满足规则2的方式，使用子类便利构造器来实现父类的指定构造器。

        指定构造器和便利构造器的语法
        类的指定构造器的写法跟值类型简单构造器一样：

        init(parameters) {
            statements
        }
        便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：

        convenience init(parameters) {
            statements
        }

**/
// 指定构造器和便利构造器实战
class Food {
    var name: String
    init(name: String) {
        self.name = name;
    }
    convenience init(){
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
println(namedMeat.name)
let mysteryMeat = Food()
println(mysteryMeat.name)

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    convenience override init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let recipe = RecipeIngredient(name: "recipe", quantity: 1)
println(recipe.name)

class ShoppingListItems: RecipeIngredient {
    var purchased = false
    var description: String {
    var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? "?" : " ?"
        return output
    }
}
var breakfastList = [
    ShoppingListItems(),
    ShoppingListItems(name: "Bacon"),
    ShoppingListItems(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    println(item.description)
}

// 通过闭包和函数来设置属性的默认值
/*
class SomeClass {
    let someProperty: SomeType = {
        return someValue
    }()

}
注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
*/

struct Checkerboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
println(board.squareIsBlackAtRow(0, column: 1))
println(board.squareIsBlackAtRow(9, column: 9))








