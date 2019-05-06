//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/20.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    ///在swift4中，编译器不再自动推断，你必须显式添加@objc
    ///该组中对应的房间信息
    @objc var room_list : [[String : NSObject]]? {
        didSet { ///属性监听器
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    ///组显示的图标
    @objc var icon_name : String = "home_header_normal"
 
    ///定义主播模型对象数组
    @objc lazy var  anchors : [AnchorModel] = [AnchorModel]()
  
}
