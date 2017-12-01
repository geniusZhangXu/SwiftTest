//
//  WeChatController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/14.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit


protocol TestASwiftClassProtocal{
        
     func TestASwiftClassProtocalMethod(name:String) -> (_ youName: String) ->Int
}


class TestASwiftClass{
        
        dynamic  var aBoll :Bool = true
        var aInt : Int = 0
        dynamic func testReturnVoidWithaId(aId : UIView) {
                
            print("TestASwiftClass.testReturnVoidWithaId")
        }
}


class WeChatController: BaseWeChatController,TestASwiftClassProtocal{

        
    let testStringOne  = "testStringOne"
    let testStringTwo  = "testStringTwo"
    let testStringThr  = "testStringThr"
    //
    var TestASwiftClassDelegate:TestASwiftClassProtocal?
        
    var count:UInt32 = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*
         
         C 语言是在函数编译的时候决定调用那个函数
           在编译阶段，C要是调用了没有实现的函数就会报错
         OC的函数是属于动态调用，在编译的时候是不能决定真正去调用那个函数的，只有在运行的时候才能决定去调用哪一个函数
           在编译阶段，OC可以调用任何的函数，即使这个函数没有实现，只要声明过也就不会报错
           
         Swift 纯Swift类的函数调用已经不是OC的运行时发送消息，和C类似，在编译阶段就确定了调用哪一个函数
               所以纯Swift的类我们是没办法通过运行时去获取到它的属性和方法的
         
               对于集成与OC的类，为了兼容OC，凡是继承与OC的都是保留了它的特性的，所以可以使用Runtime获取到它的属性和方法
         
         
         @objc 是用来将Swift的API导出来给Object-C 和 Runtime使用的，如果你类继承自OC的类，这个标识符就会被自动加进去
         加了这标识符的属性、方法无法保证都会被运行时调用，因为Swift会做静态优化，想要完全被声明成动态调用，必须使用 dynamic 标识符修饰
         当然添加了 dynamic 的时候，他会自己在加上@objc这个标识符
         
         */
        
        /*
         
        let  SwiftClass = TestASwiftClass()
        let  proList = class_copyPropertyList(object_getClass(SwiftClass),&count)
        for  i in 0..<numericCast(count) {
                
                let property = property_getName(proList?[i]);
                print("属性成员属性:%@",String.init(utf8String: property!) ?? "没有找到你要的属性");
        }
        
        
        let  mthList = class_copyMethodList(object_getClass(SwiftClass),&count)
        for  index in 0..<numericCast(count) {
                
                 let method = method_getName(mthList?[index])

                 print("属性成员方法:%@",String.init(NSStringFromSelector(method!)) ?? "没有找到你要的方法")

        }
        
        let IvarList = class_copyIvarList(object_getClass(SwiftClass),&count)
        for index in 0..<numericCast(count) {
                
                let Ivar = ivar_getName(IvarList?[index])
                print("属性成员变量:%@",String.init(utf8String: Ivar!) ?? "没有找到你想要的成员变量")
                //_ =  self.TestASwiftClassDelegate?.TestASwiftClassProtocalMethod(name: "zhangxu")
        }
        */
        
        let protocalList = class_copyProtocolList(object_getClass(self),&count)
        for index in 0..<numericCast(count) {
                
                let protocal = protocol_getName(protocalList?[index])
                print("协议:%@",String.init(utf8String: protocal!) ?? "没有找到你想要的协议")
        }
        
        
        /*
         
         OC的动态性最常用的其实就是方法的替换，将某个类的方法替换成自己定义的类，从而达到Hook的作用，
         对于纯粹的Swift类，由于前面的测试你知道无法拿到类的属性饭方法等，也就没办法进行方法的替换
         
         但是对于继承自NSObject的类，由于集成了OC的所有特性，所以是可以利用Runtime的属性来进行方法替换
         
         */
        
        self.ChangeMethod()
        self.originaMethod()
        self.swizzeMethod()
        
        // 关联属性
        /*
         第一个参数是给谁添加关联属性
         第二个参数是关联对象唯一的Key
         第三个参数是关联对象的Value
         第四个参数是关联的策略
        */
        //objc_setAssociatedObject(Any!, key: UnsafeRawPointer!, value: Any!, policy: objc_AssociationPolicy)
        
        /*
         第一个参数是取谁的属性
         第二个参数是属性的唯一的Key
         */
        //objc_getAssociatedObject(object: Any!, key: UnsafeRawPointer!)

    }
            
    func ChangeMethod() -> Void {
        
        // 获取交换之前的方法
        let originaMethodC = class_getInstanceMethod(object_getClass(self), #selector(self.originaMethod))
        // 获取交换之后的方法
        let swizzeMethodC  = class_getInstanceMethod(object_getClass(self), #selector(self.swizzeMethod))
        
        // let addMethod = class_addMethod(object_getClass(self),#selector(self.swizzeMethod), method_getImplementation(swizzeMethodC), method_getTypeEncoding(swizzeMethodC))
        
        //print("你用originaMethodC的实现代替了swizzeMethodC方法")
        //class_replaceMethod(object_getClass(self), #selector(self.swizzeMethod), method_getImplementation(originaMethodC), method_getTypeEncoding(originaMethodC))
        
         print("你交换两个方法的实现")
         method_exchangeImplementations(originaMethodC, swizzeMethodC)
        
    }
        
    dynamic func originaMethod() -> Void {
                
         print("我是交换之前的方法")
    }
       
    dynamic func swizzeMethod() -> Void {
                
         print("我是交换之后的方法")
        
    }
    
    
    func TestASwiftClassProtocalMethod(name: String) -> (_ youName: String) -> Int {
                
                let returnFunc = {(youName: String) -> Int in
                        
                     var codeDete = 20171122
                     if name == "zhangxu" {
                                
                            codeDete = 607
                     }
                     return codeDete
                }        
                return returnFunc
   
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
