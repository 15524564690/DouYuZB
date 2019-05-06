//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{
    func loadFunnyData (finishedCallback : @escaping () -> ()){
        loadAnchorData(isGroupData : false,URLStirng: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit": 30, "offset" : 0], finishedCallback: finishedCallback)
    }

}
