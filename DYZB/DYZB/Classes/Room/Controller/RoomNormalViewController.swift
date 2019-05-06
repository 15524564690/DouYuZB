//
//  RoomNormalViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/3/1.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController ,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1.隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
//        //2.保留手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
