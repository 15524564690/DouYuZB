//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/21.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell : UICollectionViewCell {
    //MARK;控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //mark;定义模型属性
    var cycleModel : CycleModel? {
        didSet { 
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
