//
//  AnchorGroup.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    
    var room_list : [[String : Any]]?{
        didSet{
            guard let room_list = room_list  else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel(dict:dict as! [String : NSObject]))
            }
        }
    }
    var icon_name : String = "home_header_hot"
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()

}
