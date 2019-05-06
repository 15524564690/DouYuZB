//
//  CollectionViewBase Cell.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/21.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewBase_Cell: UICollectionViewCell {
    ///控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    ///定义模型属性
    var anchor : AnchorModel? {
        didSet{
            //0校验模型是否有值
            guard let anchor = anchor else {return}
            //1取出在线人数显示文字
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //2昵称显示
            nickNameLabel.text = anchor.nickname
            
            
            //3显示封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}

