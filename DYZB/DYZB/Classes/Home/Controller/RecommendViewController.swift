//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/22.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit


private let KCycleViewH = kScreenW * 3 / 8
private let KGameViewH :CGFloat = 90


class RecommendViewController: BaseAnchorViewController {
    
    //添加懒加载属性
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView : RecommendCycleView = {
        let cycleView  = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(KCycleViewH + KGameViewH), width: kScreenW, height: KCycleViewH)
        return cycleView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: kScreenW, height: KGameViewH)
        return gameView
    }()

    
}
//设置ui界面内容
extension RecommendViewController {
    override func setupUI(){
        //1. 先调用super.setupUI
        super.setupUI()
        //2 将cycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        //3将gameView添加到UICollectionView中
        collectionView.addSubview(gameView)
        //4设置collectonview的内边距
        collectionView.contentInset = UIEdgeInsets(top: (KCycleViewH + KGameViewH), left: 0, bottom: 0, right: 0)
    }
}
//mark;  --请求数据
extension RecommendViewController {
       override func loadData() {
        //0 给父类的ViewModel 赋值
        baseVM = recommendVM
        //1.请求推荐数据
        recommendVM.requestDate{
            //1 展示推荐数据
            self.collectionView.reloadData()
            //2 将数据传递给gameView
            var groups = self.recommendVM.anchorGroups
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            // 2.2.添加更多元素
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
            //3. 数据请求完成
            self.loadDataFinished()
        }
        //2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1. 取出prettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! CollectionViewPrettyCell
            //2. 设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else{
          return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: KNormalItemW, height: KPrettyItemH)
        }
        return CGSize(width: KNormalItemW, height: KNormalItemH)
    }
}
