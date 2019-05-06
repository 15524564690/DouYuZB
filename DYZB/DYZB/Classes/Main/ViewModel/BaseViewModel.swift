//
//  BaseViewModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup]  = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool,URLStirng : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLString: URLStirng,parameters : parameters) { (result) in
            //1 对结果进行处理
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            //2 判断是否为分组数据
            if isGroupData {
                //2.1便利数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append( AnchorGroup(dict : dict))
                }
            }else{
                //2.2.1创建组
                let group = AnchorGroup();
                //2.2.2遍历dataArray的所有字典
                for  dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                //2.2.3将group添加到anchorGroups中
                self.anchorGroups.append(group)
            }
            
            
            //3 完成回调
            finishedCallback()
        }
    }
}
