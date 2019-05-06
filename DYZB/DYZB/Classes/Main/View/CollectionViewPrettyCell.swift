//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/23.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionViewBase_Cell {
    ///控件属性
    @IBOutlet weak var cityBtn: UIButton!
    ///定义属性
    override var anchor : AnchorModel? {
        didSet{
            //1将属性传递给父类
            super.anchor = anchor
            //2城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

            
        }
    }

}
