//
//  NSRecursiveLock.swift
//  SwiftTest
//
//  Created by SKOTC on 2017/11/30.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit


class NSRecursiveLockCon: ThreadLockController {
    
    // 队列标识String
    private let queueLabel = "queueLabel"
        
    let recursiveLock = NSRecursiveLock()
    var imageMutableArray:Array<Any> = Array.init()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for  i in 0...1000 {
                
            imageMutableArray.append("imageArray==="+String(i))
        }
        print("NSRecursiveLockCon初始化的数组个数是",imageMutableArray.count )
    }
    
    // 递归调用
    func removeFromImageArray() -> Void {
        
        recursiveLock.lock()
        if (imageMutableArray.count>0) {
                
            imageMutableArray.removeFirst()
            self.removeFromImageArray()
        }
        recursiveLock.unlock()
    }
    
        
    // MARK: - removeFromDataImageArray
    // 模仿递归调用
    override func removeFromDataImageArray() -> Void {
        
        let dispatchGroup  = DispatchGroup.init()
        let dispatchQueue  = DispatchQueue.init(label:queueLabel, qos: .default, attributes: .concurrent)
        dispatchQueue.async(group: dispatchGroup, qos: .default, flags: DispatchWorkItemFlags.noQoS) {
                
            self.removeFromImageArray()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
                
            self.now = CFAbsoluteTimeGetCurrent()
            let resultString = "操作开始时间:" + String(describing: self.then) + "\n结束时间:"+String(describing: self.now) + "\n整个操作用时:"+String(self.now! - self.then!) + "ms"
            self.resulttextView.text = resultString
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
