//
//  CollectionHeaderView.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group: AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_hot")
        }
    }
}
