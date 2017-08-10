//
//  MainViewController.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/9.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(HomeViewController(), title: "首页", imageName:"btn_home_normal")
        addChildViewController(LiveViewController(), title: "直播", imageName:"btn_live_normal")
        addChildViewController(FollowViewController(), title: "关注", imageName:"btn_column_normal")
        addChildViewController(ProfileViewController(), title: "我的", imageName:"btn_user_normal")
        
    }
    
    func addChildViewController(_ childController: UIViewController,title:String,imageName:String) -> Void {
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        tabBar.tintColor = UIColor.orange
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        addChildViewController(nav)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
