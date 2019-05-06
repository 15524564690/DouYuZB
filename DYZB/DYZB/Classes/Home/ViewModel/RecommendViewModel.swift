//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/20.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class RecommendViewModel  : BaseViewModel{
    //mark; 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

// mark; 发送网络请求

extension RecommendViewModel {
    //请求推荐数据
    func requestDate(finishCallback : @escaping ()->())  {
        //0定义参数
        let parameters =  ["limit" : "4","offset" : "0","time": NSDate.getCurrentTime() as NSString ]
        //创建Group
        let dgroup = DispatchGroup()
        
        //1 请求第一部分推荐数据
        dgroup.enter()
        //http://capi.douyucdn.cn/api/v1/getBigDataRoom?time=1550644779
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", parameters: ["time" :NSDate.getCurrentTime() as NSString ]) { (result) in
//            print(result)
            //1 将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //2 根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3遍历数组，获取字典，并将字典转成模型对象
           
           
             //3.1 给组设置属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2获取直播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3离开组
            dgroup.leave()
        }
        //2 请求第二部分颜值数据
        dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
//            print(result)
            //1 将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //2 根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3遍历数组，获取字典，并将字典转成模型对象
           
            //3.1 给组设置属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2获取直播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.3离开组
            dgroup.leave()
        }
        //请求2-12游戏数据
        dgroup.enter()
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1550632664
//        print(NSDate.getCurrentTime())
        loadAnchorData(isGroupData : true,URLStirng: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            //离开组
            dgroup.leave()
        }
        // 6所有的数据请求到排序
        dgroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    //请求轮播数据
    func requestCycleData (finishCallback : @escaping ()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.字典转模型对象
            for dict in dataArray {
                let cm  = CycleModel(dict: dict)
                self.cycleModels.append(cm)
            }
            finishCallback()
        }
    }
}
