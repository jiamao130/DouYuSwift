//
//  BaseViewModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel{
    func loadAnchorData(isGroupData: Bool ,URLString: String,parameters: [String : Any]? = nil,finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: URLString) { (result) in
            
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            if isGroupData == true{
                for dict in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else{
                let group = AnchorGroup()
                for dict in dataArray{
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
        }
    }
}
