//
//  TabBarViewController.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 06/05/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeScreen = HomeViewController()
        homeScreen.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), selectedImage: UIImage(systemName: "homekit"))
//        let homeNavigationController = UINavigationController(rootViewController: homeScreen)

        setViewControllers([homeScreen], animated: true)
    }
}
