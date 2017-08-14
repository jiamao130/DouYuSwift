//
//  FunnyViewModel.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{

    
}

extension FunnyViewModel{
    func loadFunnyData(finishedCallback: @escaping() ->()) {
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters:["limit" : 30, "offset" : 0]) {
            finishedCallback()
        }
    }
}
