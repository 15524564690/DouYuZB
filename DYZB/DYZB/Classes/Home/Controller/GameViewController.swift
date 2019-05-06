//
//  GameViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/27.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kEdgeMargin * 2) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHederViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let KGameCellID = "KGameCellID"
private let KHeaderViewID = "KHeaderViewID"

class GameViewController: BaseViewController {
    //MARK; 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHederViewH)
        //2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
              collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
        
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHederViewH + kGameViewH), width: kScreenW, height: kHederViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常用"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    //MARK; 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       loadData()
    }
    

}
//MARK; 设置UI界面
extension GameViewController {
    override func setupUI() {
        //0 给contentView赋值
        contentView = collectionView
        //1 添加collectionView
        view.addSubview(collectionView)
        //2 添加HeaderView
        collectionView.addSubview(topHeaderView)
        //3 将常用游戏的view添加到collectionView中
        collectionView.addSubview(gameView)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHederViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        super.setupUI()
        
    }
}

//MARK; 请求数据
extension GameViewController {
    fileprivate func loadData(){
        gameVM.loadAllGameDate {
            //1. 展示全部游戏
            self.collectionView.reloadData()
            //2. 展示常用游戏
            self.gameView.groups = Array(self.gameVM.games[0..<15])
            //3. 数据请求完成
            self.loadDataFinished()
        }
        
    }
}

//MARK; 遵守UICollectionView的数据源&代理协议
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1. 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! CollectionGameCell
        cell.baseGame = gameVM.games[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1. 取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! CollectionHeaderView
        //2. 给Header设置属性
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
