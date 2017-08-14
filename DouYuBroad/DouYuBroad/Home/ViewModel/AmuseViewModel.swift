//
//  AmuseViewModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
}

extension AmuseViewModel{
    
    func loadAmuseData(finishedCallback: @escaping() -> ()) {
        
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            finishedCallback()
        }
        
    }
    
}
