//
//  CollectionPrettyCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: BaseCollectionViewCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: AnchorModel?{
        
        didSet{
            
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
    
    
}
