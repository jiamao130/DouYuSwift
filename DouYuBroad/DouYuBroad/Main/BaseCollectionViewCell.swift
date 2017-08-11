//
//  BaseCollectionViewCell.swift
//  DouYuBroad
//
//  Created by 贾卯 on 2017/8/11.
//  Copyright © 2017年 贾卯. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchor: AnchorModel?{
        
        didSet{
            
            guard let anchor = anchor else {
                return
            }
            onlineBtn.setTitle("\(anchor.online)" , for: .normal)
            nicknameLabel.text = anchor.nickname
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
    
}
