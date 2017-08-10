//
//  NetworkTools.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkTools {

    class func requestData(type: MethodType,URLString: String, parameters: [String: NSString]? = nil,finishedCallback: @escaping (_ result: Any) -> ()){
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
