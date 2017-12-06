//
//  POSIXController.swift
//  SwiftTest
//
//  Created by SKOTC on 2017/12/1.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class POSIXController: ThreadLockController {

    var imageMutableArray:Array<Any> = Array.init()
        
    //初始化pthread_mutex_t类型变量
    var mutex:pthread_mutex_t = pthread_mutex_t()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化
        pthread_mutex_init(&mutex,nil)
        // Do any additional setup after loading the view.
        for  i in 0...1000 {
                
                imageMutableArray.append("imageArray==="+String(i))
        }
        print("NSLock初始化的数组个数是",imageMutableArray.count)
    }
        
    // MARK: - startTestBtnAction
    override func removeFromDataImageArray() -> Void {
        
       
        while (true) {
                
                // 加锁
                pthread_mutex_lock(&mutex)
                if (imageMutableArray.count > 0) {
                        
                        imageMutableArray.removeFirst()
                }else{
                        
                        now = CFAbsoluteTimeGetCurrent()
                        let resultString = "操作开始时间:" + String(describing: then) + "\n结束时间:"+String(describing: now) + "\n整个操作用时:"+String(now! - then!) + "ms"
                      
                        DispatchQueue.main.async {
                                
                                self.resulttextView.text = resultString
                        }
                        pthread_mutex_unlock(&mutex);
                        return
                }
                // 解锁
                pthread_mutex_unlock(&mutex)
        }
    }
    
        
    /* o
         Swift 的deinit函数实际的作用和OC中的dealloc函数是一样的
         对象的释放  通知  代理等等的处理都是在这里处理的
         
    */
    deinit {
        
        pthread_mutex_destroy(&mutex);  //释放该锁的数据结构
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
