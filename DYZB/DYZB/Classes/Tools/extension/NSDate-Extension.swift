//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by 赵斌 on 2019/2/20.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import Foundation

extension NSDate {
    static func getCurrentTime() ->  String {
        //获取当前时间
        let now = NSDate()
        //当前时间的时间戳
        let interval = Int(now.timeIntervalSince1970)
//        let timeInterval:TimeInterval = now.timeIntervalSince1970
//        let timeStamp = Int(timeInterval)
        return "\(interval)"
    }
}
