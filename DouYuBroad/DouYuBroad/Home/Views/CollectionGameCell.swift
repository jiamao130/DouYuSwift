//
//  CollectionGameCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/11.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    
    var group: AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            guard let iconURL = URL(string: (group?.icon_url)!) else {
                
                iconImageView.image = UIImage(named:"home_more_btn")
                return
                
            }
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named:"home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
