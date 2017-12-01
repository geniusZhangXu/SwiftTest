//
//  MeController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/14.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class MeController: BaseMeController {

    var tableViewDelegate:MeTableViewDelegate?
    let dataSource:Array<String> = ["NSLock","NSCondition","NSConditionLock","NSRecursiveLock","@synchronized ","dispatch_semaphore_t","pthread_mutex_t"]
    
    // private 是权限   static表示只能被初始化一次
    private static let cellReuseIdentifier = "cellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 初始化TableView
        self.initDelegate()
    }
    
    // MARK: - initTableView & Delegate
    // MARK: - 
    func initDelegate() -> Void {
        
        tableViewDelegate = MeTableViewDelegate.init(dataSource: dataSource, cellReuseIdentifier: MeController.cellReuseIdentifier)
        
        // 点击闭包
        tableViewDelegate?.cellDidSelected = { (indexPath: IndexPath) -> Void in
           
            self.cellDidSelectedAction(indexPath: indexPath)
        }
        // tabelView 注册Cell以及代理设置
        self.meTableView.register(UITableViewCell.self, forCellReuseIdentifier: MeController.cellReuseIdentifier)
        self.meTableView.delegate   = tableViewDelegate
        self.meTableView.dataSource = tableViewDelegate
        self.meTableView.tableFooterView = UIView()
        self.view.addSubview(self.meTableView)
        
    }
    
    // MARK: - TabelViewDidSelected
    func cellDidSelectedAction(indexPath: IndexPath) -> Void {
        
        var nsLockController:UIViewController?
        switch indexPath.row {
                
        case 0:
                nsLockController   = NSLockController()
        case 1:
                nsLockController   = NSConditionController()
        case 2:
                nsLockController   = NSConditionLockCon()
        case 3:
                nsLockController   = NSRecursiveLockCon()
        case 4:
                nsLockController   = SynchronizedController()
        case 5:
                nsLockController   = SemaphoreController()
        case 6:
                nsLockController   = POSIXController()
        default:
                break
        }
        
        nsLockController?.hidesBottomBarWhenPushed = true
        nsLockController?.title = dataSource[indexPath.row]
        self.navigationController?.pushViewController(nsLockController!, animated: true)
    }
    
    // 懒加载TableView
    lazy var meTableView = {
        
        () -> UITableView in
        
        let meTableView = UITableView.init(frame: self.view.frame, style: UITableViewStyle.plain)
        return meTableView
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
