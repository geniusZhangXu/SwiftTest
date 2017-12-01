//
//  SynchronizedController.swift
//  SwiftTest
//
//  Created by SKOTC on 2017/11/30.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class SynchronizedController: ThreadLockController {

    var imageMutableArray:Array<Any> = Array.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for  i in 0...1000 {
                
                imageMutableArray.append("imageArray==="+String(i))
        }
        print("你初始化的数组个数是",imageMutableArray.count )
    }
    
    // MARK: - removeFromDataImageArray
    override func removeFromDataImageArray() -> Void {
        
        while (true) {

                //互斥锁
                objc_sync_enter(self)
                
                if (imageMutableArray.count > 0) {
                        
                        imageMutableArray.removeFirst()
                        
                }else{
                        
                        now = CFAbsoluteTimeGetCurrent()
                        let resultString = "操作开始时间:" + String(describing: then) + "\n结束时间:"+String(describing: now) + "\n整个操作用时:"+String(now! - then!) + "ms"
                        DispatchQueue.main.async {
                                
                                self.resulttextView.text = resultString
                        }
                        return
                }
                
                objc_sync_exit(self)
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
