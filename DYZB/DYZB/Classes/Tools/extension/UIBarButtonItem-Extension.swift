//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/17.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
//    class func createItem(imageName : String,highImageName : String,size :CGSize  ) -> UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    //便利构造函数1convenience开头2调用一个设计构造函数(self)
    convenience init(imageName : String,highImageName : String = "",size :CGSize = CGSize.zero ) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
