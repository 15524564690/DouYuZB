//
//  AmuseMeunViewCell.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
private let KGameCellID = "KGameCellID"

class AmuseMeunViewCell: UICollectionViewCell {
    // MARK; 数组模型
    var groups : [AnchorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    // MARK; 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK; 从xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
    }
    //MARK; layoutSubViews 在此处拿到的frame正确
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

// MARK; 遵守UIcollectionView的数据源
extension AmuseMeunViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        
        //2 给cell设置数据
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
}
