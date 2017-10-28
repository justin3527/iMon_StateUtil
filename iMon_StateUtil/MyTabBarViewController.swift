//
//  MyTabBarViewController.swift
//  iMon_StateUtil
//
//  Created by naver on 2017. 7. 30..
//  Copyright © 2017년 ansi. All rights reserved.
//

import Foundation
import UIKit
import BATabBarController

class MyTabBarViewController : BATabBarController{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "resourceViewToNavigation")
        let barItem1 = BATabBarItem(image: nil, selectedImage: nil)
        
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "allocatorViewToNavigation")
        let barItem2 = BATabBarItem(image: nil, selectedImage: nil)
        
        let tabBarController = BATabBarController()
        tabBarController.viewControllers = [vc1!,vc2!]
        tabBarController.tabBarItems = [barItem1!, barItem2!]
        tabBarController.tabBarBackgroundColor = UIColor.black
        tabBarController.tabBarItemStrokeColor = UIColor.red
        tabBarController.setSelectedView(vc1, animated: true)
        self.view.addSubview(tabBarController.view)
        
        
    }
    
    override func tabBar(_ tabBar: BATabBar!, didSelectItemAt index: UInt) {
        
    }
    
    
}
