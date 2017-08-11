//
//  AnchorGroup.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    var room_list : [[String : NSObject]]?{
        didSet{
            guard let room_list = room_list  else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel(dict:dict))
            }
        }
    }
    var tag_name: String = ""
    var icon_name : String = "home_header_hot"
    var icon_url : String = ""
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
