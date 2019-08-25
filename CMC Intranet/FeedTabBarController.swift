//
//  FeedTabBarController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 7/22/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class FeedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = with(UIViewController()) {
            $0.tabBarItem = UITabBarItem(title: "First", image: .none, tag: 0)
        }

        let secondViewController = with(UIViewController()) {
            $0.tabBarItem = UITabBarItem(title: "Second", image: .none, tag: 1)
        }

        let thirdViewController = with(UIViewController()) {
            $0.tabBarItem = UITabBarItem(title: "Third", image: .none, tag: 2)
        }

        let fourthViewController = with(UIViewController()) {
            $0.tabBarItem = UITabBarItem(title: "Fourth", image: .none, tag: 3)
        }

        let fifthViewController = with(UIViewController()) {
            $0.tabBarItem = UITabBarItem(title: "Fifth", image: .none, tag: 4)
        }

        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            fourthViewController,
            fifthViewController
        ]

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )
    }

    @objc func openSettings() {
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        present(settingsNavigationController, animated: true, completion: nil)
    }
}
