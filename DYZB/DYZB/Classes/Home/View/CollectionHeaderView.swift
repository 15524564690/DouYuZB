//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/23.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    //mark; 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    //mark; 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
// MARK; 从xib中快速创建的来方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
