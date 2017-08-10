//
//  RecommendViewModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class RecommendViewModel {

    fileprivate lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}


extension RecommendViewModel{
    
    func requestData() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time":NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            let group = AnchorGroup()
            group.tag_name = "热门"
            group.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
            
            dispatchGroup.leave()
            print("0")
            
        }
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters:["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            let group = AnchorGroup()
            group.tag_name = "颜值"
            group.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
            dispatchGroup.leave()
            print("1")
            
        }
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dispatchGroup.leave()
            print("2")
            
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("3")
            
        }
    }
}
