//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //定义属性
    @objc var tag_name : String = ""
    @objc var icon_url : String = ""
    //定义构造函数
    init(dict : [String :Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    ///构造函数
    override init() {
        
    }
    //用不到的属性必须覆盖该方法setValue(_ value: Any?, forUndefinedKey key: String)
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
