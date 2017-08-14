//
//  RecommendViewModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel{

    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    
}

extension RecommendViewModel{
    
    func requestCycleData(finishCallback:@escaping ()->()){
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (response) in
            
            guard let resultDict = response as? [String : AnyObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String : AnyObject]] else {return}
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict as! [String : NSObject]))
            }
            finishCallback()
        }
    }
    
    func requestData(finishCallback:@escaping ()->()) {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time":NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dispatchGroup.leave()
            
        }
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters:["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) { (response) in
            
            guard let resultDict = response as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
            
        }
        
        dispatchGroup.enter()
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]) {
            
            dispatchGroup.leave()
            
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
}
