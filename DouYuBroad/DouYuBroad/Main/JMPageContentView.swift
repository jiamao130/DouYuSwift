//
//  JMPageContentView.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/9.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

protocol JMPageContentViewDelegate: class {
    func pageContentView(contentView:JMPageContentView,progress:CGFloat,sourceIndex: Int,targetIndex: Int)
}
private let ContentCellID = "ContentCellID"
class JMPageContentView: UIView {
    
    weak var delegate: JMPageContentViewDelegate?
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentController: UIViewController?
    fileprivate var startOffsetX:CGFloat = 0
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
        
    }()
    //自定义构造函数
    init(frame: CGRect,childVcs: [UIViewController],parentController: UIViewController?) {
        self.childVcs = childVcs
        self.parentController = parentController
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JMPageContentView{
    fileprivate func setupUI(){
        for childVc in childVcs {
            parentController?.addChildViewController(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

extension JMPageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension JMPageContentView: UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count-1
            }
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            /*
            progress = 1 - currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count-1
            }
             */
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension JMPageContentView{
    
    func setCurrentIndex(currentIndex:Int) -> Void {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
