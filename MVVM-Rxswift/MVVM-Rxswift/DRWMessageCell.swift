//
//  DRWMessageCell.swift
//  tcy
//
//  Created by dengrui on 16/4/28.
//  Copyright © 2016年 dengrui. All rights reserved.
//

import UIKit
import SDWebImage

class DRWMessageCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var message: DRResult<DRWMessageModel>? {
        didSet {
            timeLabel.text = message!.element!.addtime
            iconView.sd_setImageWithURL(NSURL(string: message!.element!.imgurl!)!)
            offerLabel.text = message!.element!.show
            nameLabel.text = message!.element!.nickname
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
