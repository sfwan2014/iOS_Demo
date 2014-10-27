//
//  main.swift
//  SwiftScriptDemo
//
//  Created by sfwan on 14-8-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

// 附属脚本, 可以定义在 类, 结构体, 枚举中, 是访问对象, 集合, 序列的快捷方式
// 附属脚本语法
// 附属脚本允许通过在实例后面的方括号中传入一个或多个的索引值来对实例进行访问和赋值
// 定义附属脚本使用subscript关键字
/*
    subscript(index: Int) -> Int {
        get{

        }
        set(newValue) {

        }
    }
与只读计算型属性一样，可以直接将原本应该写在get代码块中的代码写在subscript中：
subscript(index: Int) -> Int {
// 返回与入参匹配的Int类型的值
}
*/
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
println("3的6倍是\(threeTimesTable[6])")

//注意：TimesTable例子是基于一个固定的数学公式。它并不适合开放写权限来对threeTimesTable[someIndex]进行赋值操作，这也是为什么附属脚本只定义为只读的原因。

struct Matrix{
    let rows: Int, columns: Int
    var grid: Double[]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[1,1] = 1.5
println("\n\(matrix[1,1])")






