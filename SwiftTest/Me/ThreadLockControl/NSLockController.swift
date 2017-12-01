//
//  NSLockController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/29.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class NSLockController: ThreadLockController {
    
    var imageMutableArray:Array<Any> = Array.init()
    let lock = NSLock.init()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for  i in 0...1000 {
                
            imageMutableArray.append("imageArray==="+String(i))
        }
        print("NSLock初始化的数组个数是",imageMutableArray.count)
    }
        
    // MARK: - startTestBtnAction
    override func removeFromDataImageArray() -> Void {
                
        // 我们使用多个线程去删除一个数组里面的东西，这样就有一个资源竞争的问题，我们看看
        // 你可以先把这里的lock加锁个解锁的方法注释掉，代码会崩溃在imageMutableArray.removeFirst()
        // 关于这样写（不加锁）时候的线程安全的问题，可以参考http://www.jianshu.com/p/2fce6a0bb17b
        
        while (true) {
                
                lock.lock()
                if (imageMutableArray.count > 0) {
                    
                    imageMutableArray.removeFirst()
                        
                }else{
                 
                    now = CFAbsoluteTimeGetCurrent()
                    let resultString = "操作开始时间:" + String(describing: then) + "\n结束时间:"+String(describing: now) + "\n整个操作用时:"+String(now! - then!) + "ms"
                        
                        /*
                           NOTE： 修改UI要在主线程，不能在子线程,刚开始疏忽报了下面的错误
                           This application is modifying the autolayout engine from a background thread after the engine was accessed from the main thread. This can lead to engine corruption and weird crashes.
                         */
                        DispatchQueue.main.async {
                                
                           self.resulttextView.text = resultString
                        }
                    return
                }
                
                lock.unlock()
        }
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
