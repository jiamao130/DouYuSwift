//
//  AmuseMenuViewCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/14.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
class AmuseMenuViewCell: UICollectionViewCell {
    
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width/4
        let itemH = collectionView.bounds.height/2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

extension AmuseMenuViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        return cell
    }
}
