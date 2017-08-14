//
//  AnchorModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id: Int = 0
    var vertical_src : String = ""
    var isVertical: Int = 0
    var room_name : String = ""
    var nickname: String = ""
    var online: Int = 0
    var anchor_city: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
