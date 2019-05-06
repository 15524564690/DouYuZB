//
//  AmuseViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit
private let KMenuViewH : CGFloat = 200
class AmuseViewController: BaseAnchorViewController {
    //MARK; 懒加载属性
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -KMenuViewH, width: kScreenW, height: KMenuViewH)
        return menuView
    }()
}

//MARK; 设置UI界面
extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        //将菜单VIEW添加到collectionView中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: KMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK; 请求数据
extension AmuseViewController {
    override func loadData() {
        //1 给父类中的ViewModel赋值
        baseVM = amuseVM
        //2 请求数据
        amuseVM.loadAmuseData {
            //1. 刷新表哥
            self.collectionView.reloadData()
            //2. 调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            //3. 数据请求完成
            self.loadDataFinished()
        }
    }
}


