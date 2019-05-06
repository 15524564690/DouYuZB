//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

private let KMeunCellID = "KMeunCellID"
class AmuseMenuView: UIView {
    //定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK; 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName:"AmuseMeunViewCell" , bundle: nil), forCellWithReuseIdentifier: KMeunCellID)
        
       
    }
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// mark; 通过xib快速创建类方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeunCellID, for: indexPath) as! AmuseMeunViewCell
        //2. 给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellDataWithCell (cell : AmuseMeunViewCell, indexPath : IndexPath) {
        //0页 : 0 - 7
        //1页 : 8 - 15
        //3页 : 16 - 23
        //1.先取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //2. 判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        //3 取出数据并且赋值给cell
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
