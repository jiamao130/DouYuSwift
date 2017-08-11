//
//  CollectionNormalCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/10.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CollectionNormalCell: BaseCollectionViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel?{
        
        didSet{
            
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}
