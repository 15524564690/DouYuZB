//
//  GameViewModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/27.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    //http://capi.douyucdn.cn/api/v1/getColumnDetail
    func loadAllGameDate(finishedCallback : @escaping() -> ()){
    NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: nil) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {return}
        
            //2. 字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            //3. 完成后通知
            finishedCallback()
        }
    }
}
