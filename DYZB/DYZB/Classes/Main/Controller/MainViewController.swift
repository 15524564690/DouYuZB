//
//  MainViewController.swift
//  DYZB
//
//  Created by 赵斌 on 2019/1/17.
//  Copyright © 2019 zhaobin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      addChildVc(storyName: "Home")
      addChildVc(storyName: "Live")
      addChildVc(storyName: "Follow")
      addChildVc(storyName: "Profile")
        
    }
    private func addChildVc (storyName : String ){
      let childVc = UIStoryboard(name: storyName, bundle:nil).instantiateInitialViewController()!
    addChild(childVc)
    }

}
