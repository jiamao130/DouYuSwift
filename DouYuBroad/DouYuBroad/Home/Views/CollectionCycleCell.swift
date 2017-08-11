//
//  CollectionCycleCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/11.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    
    
    @IBOutlet weak var iconImageVIew: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var cycleModel: CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            guard let iconURL = URL(string: (cycleModel?.pic_url)!) else {return}
            iconImageVIew.kf.setImage(with: iconURL)

        }
    }
    
    
}
