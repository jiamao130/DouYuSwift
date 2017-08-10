//
//  UIBarButtonItem-Extension.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/9.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    //便利构造函数 1.以convenience开头 2.在构造函数中必须调用一个设计构造函数（self）
    convenience init(imageName: String,higiImageName: String = "",size: CGSize = CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        if higiImageName != "" {
            btn.setImage(UIImage(named:higiImageName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        else{
            btn.sizeToFit()
        }
        self.init(customView:btn)
    }
}
