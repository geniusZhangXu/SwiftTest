//
//  BaseNavigationController.swift
//  SwiftTest
//
//  Created by Zhangxu on 2017/11/14.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


extension UINavigationController {
        
        
        var navigationGradualChangeBackgroundView:UIView{
        
                get{
                   
                   return objc_getAssociatedObject(self, &self.navigationGradualChangeBackgroundView) as! UIView;
                }
                
                set{
                
                    objc_setAssociatedObject(self, &self.navigationGradualChangeBackgroundView, navigationGradualChangeBackgroundView, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
                }
        }
        
        
        
        func setNavigationBackgroundColor (backgroundColor: UIColor) -> Void {
                
                if (self.navigationGradualChangeBackgroundView == nil) {
                        
                    self.navigationGradualChangeBackgroundView = UIView.init(frame: CGRect.init(x: 0, y: -20, width: SCREENWIDTH, height: self.view.bounds.size.height + 20))
                        
                    self.navigationGradualChangeBackgroundView.isUserInteractionEnabled = false
                    //self.navigationGradualChangeBackgroundView.autoresizingMask = UIViewAutoresizing.flexibleWidth|UIViewAutoresizing.flexibleHeight
                    
                    self.view.insertSubview(self.navigationGradualChangeBackgroundView, at: 0)
                        
                }
                
               self.navigationGradualChangeBackgroundView.backgroundColor = backgroundColor
        }
        
        
        func removeNavigationBackgroundColor() -> Void {
                
               self.navigationGradualChangeBackgroundView.removeFromSuperview()
        }
        
}

