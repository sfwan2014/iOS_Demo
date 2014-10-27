//
//  main.swift
//  SwiftARCDemo
//
//  Created by sfwan on 14-8-25.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

/*
*为了让这变成现实，只要你将一个类的实例赋值给一个属性或者常量或者变量，这个属性、常量或者变量就是这个实例的强引用(strong reference)。之所以称之为“强”引用，是因为它强持有这个实例，并且只要这个强引用还存在，就不能销毁实例。
*/
class Person {
    let name: String
    init(name: String) {
        self.name = name;
        println("\(name) is being initialized")
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
var p1: Person?
var p2: Person?
var p3: Person?
p1 = Person(name: "John Appleseed")
p2 = p1
p3 = p2

p1 = nil// 不会释放
p2 = nil// 不会释放
p3 = nil// 释放

/*
一个类的实例永远不会有0个强引用。在两个类实例彼此保持对方的强引用，使得每个实例都使对方保持有效时会发生这种情况。我们称之为强引用环。
*/
// 强引用
class People {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        println("\(name) is being deinitialized")
    }
}

class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    var tenant: People?
    deinit {
        println("Apartment #\(number) is being deinitialized")
    }
}
var jhon: People?
var number73: Apartment?
jhon = People(name: "Jhon Appleseed")
number73 = Apartment(number: 73)
//强引用环
jhon!.apartment = number73
number73!.tenant = jhon
jhon = nil
number73 = nil
// 实例得不到释放

// 解决实例间的强引用环
// 1.弱引用 (只能声明为变量类型)
/*
class People {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        println("\(name) is being deinitialized")
    }
}

class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    weak var tenant: People?
    deinit {
        println("Apartment #\(number) is being deinitialized")
    }
}
*/

// 2.无主引用
/*
和弱引用相似，无主引用也不强持有实例。但是和弱引用不同的是，无主引用默认始终有值。因此，无主引用只能定义为非可选类型（non-optional type）。在属性、变量前添加unowned关键字，可以声明一个无主引用。
注意:
当实例被销毁后，试图访问该实例的无主引用会触发运行时错误。使用无主引用时请确保引用始终指向一个未销毁的实例。 上面的非法操作会百分百让应用崩溃，不会发生无法预期的行为。因此，你应该避免这种情况。
*/
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        println("Card #\(number) is being deinitialized")
    }
}
var jack: Customer?
jack = Customer(name: "Jack Appleseed")
jack!.card = CreditCard(number: 1234_5678_9012_3456, customer: jack!)
jack = nil

/*
无主引用以及隐式展开的可选属性
上述的弱引用和无主引用的例子覆盖了两种常用的需要打破强引用环的应用场景。

Person和Apartment的例子说明了下面的场景：两个属性的值都可能是nil,并有可能产生强引用环。这种场景下适合使用弱引用。

Customer和CreditCard的例子则说明了另外的场景：一个属性可以是nil，另外一个属性不允许是nil，并有可能产生强引用环。这种场景下适合使用无主引用。

但是，存在第三种场景：两个属性都必须有值，且初始化完成后不能为nil。这种场景下，则要一个类用无主引用属性，另一个类用隐式展开的可选属性。
*/
class Country {
    let name: String
    let capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
println("\(country.name)'s capital city is called \(country.capitalCity.name)'")

// 闭包产生的强引用环
class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
//注意：asHTML声明为lazy属性，因为只有当元素确实需要处理为HTML输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello world")
println(paragraph!.asHTML())
paragraph = nil
// 解决闭包产生的强引用环
/*
在定义闭包时同时定义占有列表作为闭包的一部分，可以解决闭包和类实例之间的强引用环。占有列表定义了闭包内占有一个或者多个引用类型的规则。和解决两个类实例间的强引用环一样，声明每个占有的引用为弱引用或无主引用，而不是强引用。根据代码关系来决定使用弱引用还是无主引用。

注意：Swift有如下约束：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod（而非只是someProperty或someMethod）。这可以提醒你可能会不小心就占有了self。
*/
// 定义占有列表
// 占有列表中的每个元素都是由weak或者unowned关键字和实例的引用(self或someValue)组成.每一对都在花括号中,通过逗号分开
/*
占有列表放置在闭包参数列表和返回类型之前：
lazy var someClosure: (Int, String) -> String = {
    [unowned self] (index: Int, stringToProcess: String) -> String in
}
如果闭包没有指定参数列表或者返回类型（可以通过上下文推断），那么占有列表放在闭包开始的地方，跟着是关键字in：
@lazy var someClosure: () -> String = {
    [unowned self] in
    // closure body goes here

}
*/

// 弱引用和无主引用
/*
当闭包和占有的实例总是互相引用时并且总是同时销毁时，将闭包内的占有定义为无主引用。

相反的，当占有引用有时可能会是nil时，将闭包内的占有定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。利用这个特性，我们可以在闭包内检查他们是否存在。

注意：如果占有的引用绝对不会置为nil，应该用无主引用，而不是弱引用。

前面提到的HTMLElement例子中，无主引用是正确的解决强引用的方法。这样编码HTMLElement类来避免强引用环：
*/

class HTMLElements {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        println("\(name) is being deinitialized")
    }
}
var paragraphs: HTMLElements? = HTMLElements(name: "p", text: "hello world")
println(paragraphs!.asHTML())
paragraphs = nil






















