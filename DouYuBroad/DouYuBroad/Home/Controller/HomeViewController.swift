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
    
    fileprivate lazy var pageContentView: PageContentView = {
        let contentH = kScreenH-kStatusBarH-kNavigationBarH-kTitleViewH - kTarBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH+kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
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
    func pageTitleView(_ titleView: JMPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
        
    }
    
}

extension HomeViewController:PageContentViewDelegate{
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

