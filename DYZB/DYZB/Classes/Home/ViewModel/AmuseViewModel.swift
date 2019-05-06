//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/28.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    

}

extension AmuseViewModel {
    //http://capi.douyucdn.cn/api/v1/getHotRoom/2
    func loadAmuseData (finishedCallback : @escaping () -> ()) {
       loadAnchorData(isGroupData : true, URLStirng: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
