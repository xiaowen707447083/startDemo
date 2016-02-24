//
//  main.swift
//  读写本地文件
//
//  Created by lanou on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

import Foundation

print("Hello, World!")

//打印根目录/在ios中是沙盒目录
var nshome = NSHomeDirectory()
print(nshome)


//文档所在目录
var documentDirectory = nshome.stringByAppendingPathComponent("Documents")
print(documentDirectory)

var fileManager:NSFileManager = NSFileManager()
//创建一个目录 withIntermediateDirectories:是否覆盖
NSFileManager.defaultManager().createDirectoryAtPath("\(nshome)/测试目录_1", withIntermediateDirectories: false, attributes: nil, error: nil)

//文件路径
var filePath = documentDirectory.stringByAppendingPathComponent("测试.txt")
var str = "测试写入的数据"
//atomically:参数意思是如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.如果为NO,则直接写入目标文件里.
str.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding, error: nil)

//读取文件
var sResult = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)
println(sResult! as String)


//获取文件路径
 var paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
println(paths)

