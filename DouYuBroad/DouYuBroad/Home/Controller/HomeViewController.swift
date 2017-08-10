//
//  HomeViewController.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/9.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView: JMPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = JMPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView: JMPageContentView = {
        let contentH = kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH - kTarBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = JMPageContentView(frame: contentFrame, childVcs: childVcs, parentController: self)
        contentView.delegate = self
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController{
    
    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        setNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    fileprivate func setNavigationBar(){
        
        let size = CGSize(width: 40, height: 40)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", higiImageName: "image_my_history", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", higiImageName: "btn_search", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", higiImageName: "Image_scan", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}

extension HomeViewController: PageTitleViewDelegate{
    func PageTitleView(titleView: JMPageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController:JMPageContentViewDelegate{
    func pageContentView(contentView: JMPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgres(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

