//
//  CustomNavigationController.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else {return}
        guard let gesView = systemGes.view else {return}
        /*
        var count: UInt32 = 0
        let ivars  = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count{
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString:name!))
        }
         
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targeObjc = targets?.first else {return}
        guard let target = targeObjc.value(forKey: "target") else { return }
         let action = Selector(("handleNavigationTransition:"))
        let panGesure = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGesure)
        panGesure.addTarget(target as Any, action: action)
        */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
