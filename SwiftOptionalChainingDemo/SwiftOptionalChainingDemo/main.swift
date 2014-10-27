//
//  main.swift
//  SwiftOptionalChainingDemo
//
//  Created by sfwan on 14-8-29.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

import Foundation

// 自判断链接: 是一种可以请求和调用属性, 方法及子脚本的过程, 它的自判断性体现于请求或调用的目标当前可能``
// 自判断链接可替代强拆包
/*
通过在想调用的属性、方法、或子脚本的自判断值（optional value）（非空）后面放一个问号，可以定义一个自判断链接。这一点很像在自判断值后面放一个声明符号来强制拆得其封包内的值。他们的主要的区别在于当自判断值为空时自判断链接即刻失败，然而一般的强制拆包将会引发运行时错误。
*/
