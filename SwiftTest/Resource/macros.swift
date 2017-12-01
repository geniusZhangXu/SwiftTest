//
//  macros.swift
//  SwiftTest
//
//  Created by SKOTC on 2017/11/15.
//  Copyright © 2017年 Zhangxu. All rights reserved.
//

import Foundation
import UIKit


func RGBCOLOR(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat , _ a:CGFloat) -> UIColor  {
        
     return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha:a)
}

// 标签栏的颜色
let DEFAULT_TABBAR_COLOC = RGBCOLOR(2.0,187.0,0.0,1.0)


// 
