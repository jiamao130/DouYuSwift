//
//  CycleModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/11.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title: String = ""
    var pic_url : String  = ""
    var room: [String : Any]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room as! [String : NSObject])
        }
    }
    var anchor: AnchorModel?
    
    init(dict:[String : NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        super.setValue(value, forKeyPath: keyPath)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
