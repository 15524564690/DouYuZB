//
//  HomeViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/17.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

private  let KTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //懒加载
    private lazy var  pagetTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0 , y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let  titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView  : PangeContentView = {[weak self] in
        //确定内容的Frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - KTitleViewH - KTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KTitleViewH, width: kScreenW, height: contentH)
        //2确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())

        let contentView = PangeContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}
//MARK: 设置UI界面
extension HomeViewController {
    private func setupUI (){
        //不需要调整UIScrollView的内边距
       //automaticallyAdjustsScrollViewInsets = false
        //1设置导航栏
        setupNavigationBar()
        //2添加titleView
        view.addSubview(pagetTitleView)
        //3添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.green
    }
    private func setupNavigationBar(){
        //设置左侧
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //设置右侧
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
     
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

//Mark 遵守PageTitleViewDelegage协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titileView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    

}
//Mark 遵守PageContentViewDelegage协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PangeContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pagetTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
