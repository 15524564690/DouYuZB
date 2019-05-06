//
//  RecommendGameView.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/22.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
//注册使用的标识
private let KGameCellID = "KGameCellID"
//collectionView 内边距常量
private let KEdgeInsetMargin : CGFloat = 10
class RecommendGameView: UIView {
    //定义数据的属性
    var groups : [BaseGameModel]? {
        didSet {
            // 3.刷新数据
            collectionView.reloadData()
            
        }
    }
    //mark；控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //mark;系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随父控件拉伸而拉伸
        autoresizingMask = []
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        //给CollectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: KEdgeInsetMargin, bottom: 0, right: KEdgeInsetMargin)
       
    }
}

//mark; 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView () -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//mark; 遵守UIcollectionView的数据协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }
}

