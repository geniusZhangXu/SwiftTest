//
//  MeTableViewDelegate.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/28.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

/*
 正好在这里总结一下下面这个 _ 下划线的用法
 1、用来格式化字面量,下面的输出是：
 let a = 100_000_0000_000
 print("a=",a)
 a= 1000000000000
 
 2、忽略元祖的元素值
 3、忽略区间值
 4、忽略外部参数名
 在我们定义方法的时候，在以前2.0的Swift中，调用定义的函数的时候第一个参数的外部参数名是自动忽略的
 （应该是为了兼容OC代码）
 上面说的这一点在3.0中已经是废弃了，第一个参数外部参数名已经不再忽略
 
 func accessibi(name:String, _ sex:String, _ age:Int) -> Void { }
 调用上面函数的时候如下：（省略了第二个和第三个参数的参数名）
 self.accessibi(name: "dasdas", "dasdsadas", 222)
 
 5、定义闭包的时候，你要是给闭包参数添加了参数名，前面需要加 _
 
 */
typealias cellDidSelected = ((_ indexPath: IndexPath) -> Void)

class MeTableViewDelegate: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    // cell点击闭包
    var cellDidSelected:cellDidSelected?
    // 数据源
    var dataSourceArray:Array<String>?
    var reuseIdentifier:String?
    
    init(dataSource:Array<String> , cellReuseIdentifier:String) {
        
        dataSourceArray = dataSource
        reuseIdentifier = cellReuseIdentifier
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataSourceArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!, for: indexPath)
        if (tableViewCell == nil) {
            
            tableViewCell =  UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        }
        
        tableViewCell?.textLabel?.text = dataSourceArray![indexPath.row]
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.cellDidSelected!(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
}
