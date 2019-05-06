//
//  PageTitleView.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/17.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

//MARK; 定义协议
protocol PageTitleViewDelegate : class {//协议只能被类遵守
    func pageTitleView(titileView: PageTitleView, selectedIndex index :Int)
}
//MARK; 定义常量
private let KScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    //Mark : 定义属性
    private var currentIndex : Int = 0
    private var titles :[String]
    weak var delegate : PageTitleViewDelegate?
    
    //懒加载
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        var scrollerLine = UIView()
        scrollerLine.backgroundColor = UIColor.orange
        return scrollerLine
    }()
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI () {
        //添加UIscreenView
        addSubview(scrollView)
        scrollView.frame  = bounds
        //添加title对应的label
        setTitleLabels()
        //设置底线和滚动滑块
        setupBottomMenuAndScrollLine()
    }
    private func setTitleLabels (){
        //确定label的一些frame的值
        // 设置label fram
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - KScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated(){
            //创建UILabel
            let label = UILabel()
            //设置UILable属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            // 设置label fram
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width:labelW, height:  labelH)
            //将label 添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            //给label 添手势
            label.isUserInteractionEnabled = true
            let tagGes = UITapGestureRecognizer(target: self, action:  #selector(self.titleLabelClick))
            label.addGestureRecognizer(tagGes)
        }
    }
    private func setupBottomMenuAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //获取第一个label
        guard let firstLable = titleLabels.first else {return}
        firstLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        //添加scroll设置属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - KScrollLineH, width: firstLable.frame.width, height: KScrollLineH)
        
    }
   
}

//mark 监听lable 点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes :UITapGestureRecognizer){
        //0获取当前label
        guard let currentLable = tapGes.view as? UILabel else { return }
        //1如果是重复点击同一个title，那么直接返回
        if currentLable.tag == currentIndex {return}
        //2 获取之前的lable
        let oldLabel = titleLabels[currentIndex]
        //3切换文字颜色
        currentLable.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //4保存最新的label的下标值
        currentIndex = currentLable.tag
        //5滚动条位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
             self.scrollLine.frame.origin.x = scrollLineX
        }
        //66通知代理
        delegate?.pageTitleView(titileView: self, selectedIndex: currentIndex)
    }
}

//MARK; 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int,targetIndex : Int){
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //2.处理滑块逻辑
        let movieTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = movieTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3.处理颜色的渐变(复杂)
        //3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g:  kSelectColor.1 - colorDelta.1 * progress, b:  kSelectColor.2 - colorDelta.2 * progress)
         //3.2 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 +  colorDelta.2 * progress)
        //4. 记录最新的index
        currentIndex = targetIndex
        
    }
}
