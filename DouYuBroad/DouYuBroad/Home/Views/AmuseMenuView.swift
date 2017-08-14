//
//  AmuseMenuView.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

private var kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
        
    }
        
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        
    }
}

extension AmuseMenuView{
    class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil{return 0}
        let pageNum = ((groups?.count)! - 1)/8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell: AmuseMenuViewCell,indexPath: IndexPath){
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        print(startIndex,endIndex)
        // 2.判断越界问题
        if groups?.count == 0 {return}
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.clipsToBounds = true
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
    
}

extension AmuseMenuView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}


