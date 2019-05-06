//
//  CycleModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/21.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    @objc var title : String = ""
    // 展示图品的地址
    @objc var pic_url : String = ""
    // 主播信息对应的字典
    @objc var room : [String : NSObject]? {
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    @objc var anchor : AnchorModel?
    
    //mark; 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    //用不到的属性必须覆盖该方法setValue(_ value: Any?, forUndefinedKey key: String)
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    
}
