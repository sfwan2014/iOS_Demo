//
//  main.swift
//  SwiftDemo001
//
//  Created by sfwan on 14-6-24.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

/*
// 函数与闭包
func greet(name:String, day:String)->String{
    return "Hello \(name), tody is \(day)"
}

var teacher:Teacher
teacher = Teacher(name: "Jhon", age: 31, sex: true, salary: 5.6)
var des = teacher.simpleAction()
println("\(des)")

var stu:Student!
stu = Student(name: "jack", age: 16, sex: false, grade: 78)
des = stu.simpleAction()
println("\(des)")

var s = greet("Bob", "Tuesday")
println("\(s)")


func getGasPrices()->(Double, Double, Double){
    return (3.12, 3.41, 4.21)
}


getGasPrices()


func sumOf(numbers:Int...)->Int{
    var sum = 0
    
    for number in numbers{
        sum += number
    }
    
    return sum
}


var result = sumOf(1,3,2,5)
println("\(result)")



func returnFifteen() -> Int{
    var y = 10
    func add(){
        y += 5
    }
    
    add()
    
    return y
}

var f = returnFifteen()
println("\(f)")



func makeIncrementer()->(Int->Int){
    func addOne(number:Int)->Int{
        return 1 + number
    }
    
    return addOne
}

var increment = makeIncrementer()
var incr = increment(7)
println("\(incr)")



func hasAnyMatches(list:Int[], condition:Int->Bool)->Bool{
    for item in list{
        if condition(item){
            return true
        }
    }
    
    return false
}

func lessThanTen(number:Int)->Bool{
    return number < 10
}

var numbers = [1,32,91,11,23,11]
var ha = hasAnyMatches(numbers, lessThanTen)

println("\(ha)")



numbers.map({
    (number:Int) -> Int in
    let result = 3 * number
    return result
})

var rs = numbers.map({number in 3 * number})
println("\(rs)")





//enum Rank:Int{
//    case Ace = 1,
//    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten,
//}

enum Rank: Int {
    
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescrition() -> String {
        
        switch self {
            
        case .Ace: return "ace"
            
        case .Jack: return "jack"
            
        case .Queen: return "queen"
            
        case .King: return "king"
            
        default: return String(self.toRaw())
            
        }
        
    }
    
}

let ace = Rank.Jack
let aceRawValue = ace.toRaw()
println("\(ace)")
println("\(aceRawValue)")

//let convertedRank = Rank.fromRaw(){
//    let threeDescription = convertedRank.simpleDescription()
//}



//let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")



func sumof(numbers:Int...) ->Int{
    var sum = 0;
    for number in numbers{
        sum += number
    }
    
    return sum
}


var rss = sumof(1,2,3,4,5,6,7,8,9)

println("\(rss)")

*/

let str = "1234??"
println(countElements(str))


