//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
let KItemMargin : CGFloat = 10
let KNormalItemW : CGFloat = (kScreenW - 3 * KItemMargin) / 2
let KNormalItemH : CGFloat = KNormalItemW * 3 / 4
let KPrettyItemH : CGFloat = KNormalItemW * 4 / 3
let KHeaderViewH :CGFloat = 50

private let KNormalCellID = "KNormalCellID"
 let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"
class BaseAnchorViewController: BaseViewController {
    //MARK; 定义属性
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = { [unowned self ] in
        //创建流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: KNormalItemW, height: KNormalItemH)
        //行间距
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = KItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: KHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        //创建uicollectionView
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        return collectionView
        }()
    //MARK; 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

//MARK; 设置ui界面
extension BaseAnchorViewController {
    override func setupUI(){
        //1.给父类中内容的引用进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //调用super.setupUI()
        super.setupUI()
    }
}
// MARK; 请求数据
extension BaseAnchorViewController {
   @objc func loadData() {}
}

// MARK; 遵守UICollectonView的数据源
extension BaseAnchorViewController : UICollectionViewDataSource   {
    //几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if baseVM == nil {
//             return 1
//        }
        return baseVM.anchorGroups.count
    }
    //每组几条
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if baseVM == nil {
//            return 20
//        }
        return baseVM.anchorGroups[section].anchors.count
    }
    //返回cell的方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! CollectionNormalCell
        // 2. 给cell 设置数据
//        if baseVM == nil {
//            return cell
//        }
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1 取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2 给headerView 设置数据
//        if baseVM == nil {
//            return headerView
//        }
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

// MARK; 遵守UICollectonView的数据源和代理协议
extension BaseAnchorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.取出对应的主播信息
        let ancher = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        //2.判断是修长房间还是普通房间
        ancher.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
        
    }
    private func presentShowRoomVc (){
        //1.创建showRoomVc
        let showRoomVc = RoomShowViewController()
        
        //2.以Modal方式弹出
        present(showRoomVc, animated: true, completion: nil)
        
    }
    private func pushNormalRoomVc (){
        //1.创建NormalRoomVc
        let normalRoomVc = RoomNormalViewController()
        //2.以push的方式弹出
        navigationController?.pushViewController(normalRoomVc, animated: true)
        

    }
}
