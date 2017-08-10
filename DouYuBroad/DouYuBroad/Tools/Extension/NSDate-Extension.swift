//
//  NSDate-Extension.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import Foundation

extension NSDate{
    
    class func getCurrentTime()->NSString {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)" as NSString
    }
}
