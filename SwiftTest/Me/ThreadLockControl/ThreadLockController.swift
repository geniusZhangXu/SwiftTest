//
//  ThreadLockController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/29.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit
import SnapKit

class ThreadLockController: BaseViewController {
    
    // 用这两个数值记录操作的开始和结束时间
    var then:Double?
    var now :Double?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addLayoutForAllControls()
        
    }
    
    // MARK: - removeFromDataImageArray
    func removeFromDataImageArray() -> Void {
        
        
    }
        
    // MARK: - startTestBtnAction
    func startTestBtnAction() -> Void {
        
        // 我们使用多个线程去删除一个数组里面的东西，这样就有一个资源竞争的问题，我们看看
        print("开始删除操作")
        then = CFAbsoluteTimeGetCurrent()
        for _ in 0...5 {
                
            DispatchQueue.global().async {
                
                // 全局同步队列里面的异步线程操作数组
                self.removeFromDataImageArray()
            }
        }
    }
    
    // MARK: - addLayoutForAllControls
    func addLayoutForAllControls() -> Void {
        
        self.view.addSubview(self.startTestBtn)
        self.startTestBtn.snp.makeConstraints { (make) in
                
                make.height.equalTo(50)
                make.width.equalTo(100)
                make.top.equalTo(100)
                make.centerX.equalTo(self.view)
        }
        
        self.view.addSubview(self.resulttextView)
        self.resulttextView.snp.makeConstraints { (make) in
                
                make.top.equalTo(self.startTestBtn.snp.bottom).offset(50)
                make.width.equalTo(self.view).multipliedBy(0.8)
                make.height.equalTo(100)
                make.centerX.equalTo(self.view)
        }
    }
    
    // MARK: - lazyControls
    lazy var startTestBtn = {
        
        () -> UIButton in
        
        let startTestBtn = UIButton.init(type: UIButtonType.custom)
        startTestBtn.addTarget(self, action: #selector(startTestBtnAction), for: UIControlEvents.touchUpInside)
        startTestBtn.setTitle("开始测试", for: UIControlState.normal)
        startTestBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        return startTestBtn
    }()
    
        
    lazy var resulttextView = {
        
        () -> UITextView in
        let resultTextView = UITextView.init(frame: CGRect.zero)
        resultTextView.layer.borderColor = UIColor.black.cgColor
        resultTextView.layer.borderWidth = 1
        return resultTextView
    }()
        
    
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
