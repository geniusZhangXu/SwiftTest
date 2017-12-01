//
//  SemaphoreController.swift
//  SwiftTest
//
//  Created by SKOTC on 2017/12/1.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class SemaphoreController: ThreadLockController {
    
    // 直接在这里初始化一个信号量
    let semaPhore = DispatchSemaphore.init(value: 1)
        
    var imageMutableArray:Array<Any> = Array.init()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        for  i in 0...1000 {
                
                imageMutableArray.append("imageArray==="+String(i))
        }
        print("DispatchSemaphore初始化的数组个数是",imageMutableArray.count)
        
    }
        
     // MARK: - startTestBtnAction
     override func removeFromDataImageArray() -> Void {
                
        while (true) {
                
                /* 也可以直接写： semaPhore.wait()
                   这里发生一个等待信号，信号量就-1，变成0 ，后面的任务就会处于等待状态，
                   等到信号量大于等于1的时候在执行,要是信号量不大于或者等于你初始化时候的值，它就一直处于等待状态
                   当然，你也可以在这里这是等待的时间  semaPhore.wait(timeout: DispatchTime.init(uptimeNanoseconds: UInt64(10)))
                   但过了这个时间之后在进入就等于是我们的锁失效了。面临的问题也就是相应的崩溃，在删除方法哪里，可以自己试一下
                 */
                _ = semaPhore.wait(timeout: DispatchTime.distantFuture)
                
                if (imageMutableArray.count > 0) {
                        
                        imageMutableArray.removeFirst()
                }else{
                        
                        now = CFAbsoluteTimeGetCurrent()
                        let resultString = "操作开始时间:" + String(describing: then) + "\n结束时间:"+String(describing: now) + "\n整个操作用时:"+String(now! - then!) + "ms"
                        
                        DispatchQueue.main.async {
                                
                                self.resulttextView.text = resultString
                        }
                        
                        // 不要忘记在这里加处理，不然return之后是执行不到下面的semaPhore.signal()代码
                        semaPhore.signal()
                        return
                }
                
                // signal() 方法，这里会使信号量+1
                   semaPhore.signal()
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
