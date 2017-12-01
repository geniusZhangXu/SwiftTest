//
//  SubTabbarController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/14.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class SubTabbarController: BaseTabbarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        self.tabBar.tintColor = DEFAULT_TABBAR_COLOC
        
        // Do any additional setup after loading the view.
        // 懒加载添加四个底层控制器
        let weChatNa      = SubNavigationController.init(rootViewController: weChatController);
        let addressBookNa = SubNavigationController.init(rootViewController: addressBookController);
        let discoverNa    = SubNavigationController.init(rootViewController: discoverController);
        let meNa = SubNavigationController.init(rootViewController: meController);
        
        self.setViewControllers([weChatNa,addressBookNa,discoverNa,meNa], animated:true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     NOTE: 懒加载知识点
           Swift 懒加载必须使用var关键字来定义演示加载属性
           不能使用let关键字，因为let定义的是常量，常量就必须在定义的时候赋值
     
           最后面的括号表示执行这个闭包
     */
    
    // 懒加载创建WeChat控制器
    lazy var weChatController = {
        () -> UIViewController  in
        let weChatController =  WeChatController()
        weChatController.tabBarItem = UITabBarItem.init(title: "WeChat", image: UIImage.init(named: "tabbar_mainframe"), selectedImage: UIImage.init(named: "tabbar_mainframeHL"))
        return weChatController
    }()
    
    lazy var addressBookController = {
        
        () -> UIViewController in
        let addressController = AddressBookController()
        addressController.tabBarItem = UITabBarItem.init(title: "通讯录", image: UIImage.init(named: "tabbar_contacts"), selectedImage: UIImage.init(named: "tabbar_contactsHL"))
        return addressController
    }()
    
    lazy var discoverController = {
        
        () -> UIViewController in
        let discoverController = DiscoverController()
        discoverController.tabBarItem = UITabBarItem.init(title: "发现", image: UIImage.init(named: "tabbar_discover"), selectedImage: UIImage.init(named:"tabbar_discoverHL"))
        return discoverController
    }()
    
    lazy var meController = {
        
        () -> UIViewController in
        let meController = MeController()
        meController.tabBarItem = UITabBarItem.init(title: "我", image: UIImage.init(named: "tabbar_me"), selectedImage: UIImage.init(named:"tabbar_meHL"))
        return meController
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
