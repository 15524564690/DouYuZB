//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/23.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionViewBase_Cell {
    ///控件属性
    @IBOutlet weak var roomNameLable: UILabel!
    ///定义属性
    override var anchor : AnchorModel? {
        didSet{
            //1将属性传递给父类
            super.anchor = anchor
            //2房间名出
            roomNameLable.text = anchor?.room_name
        }
    }
}
