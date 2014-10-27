//
//  Person.swift
//  SwiftDemo001
//
//  Created by sfwan on 14-6-26.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation
class Person{
    var name:String?
    var age:Int = 0
    var sex:Bool  = false
    init(name:String, age:Int, sex:Bool){
        self.name = name
        self.age = age
        self.sex = sex
    }
    
    func simpleAction()->String{
        return "A person heartbeat"
    }
}


class Teacher:Person{
    var salary:Double = 0
    
    init(name: String, age: Int, sex:Bool, salary:Double) {
        super.init(name: name, age: age, sex: sex)
        self.salary = salary
    }
    
    override func simpleAction()->String{
        return "A teacher teach"
    }
}

class Student:Person{
    var grade:Int = 0
    
    init(name: String, age: Int, sex: Bool, grade:Int){
        super.init(name: name, age: age, sex: sex)
        self.grade = grade
    }
    
    override func simpleAction()->String{
        return "A student study"
    }
}