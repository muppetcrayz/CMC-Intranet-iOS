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
        
//        bo7bLodFhEP#zMq)r%JmgWRC

        let firstViewController = with(TitleAndReadViewController(stateTransformation: {
            $0.favorites.sorted(by: {
                $0.value < $1.value
            })
            .map { $0.key }
        })) {
            $0.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "tab_favorites"), tag: 0)
            $0.view.backgroundColor = .white
        }
        
        let secondViewController = with(TitleAndReadViewController(stateTransformation: {
            $0.announcements
        })) {
            $0.tabBarItem = UITabBarItem(title: "Announcements", image: UIImage(named: "tab_announcements"), tag: 1)
            $0.view.backgroundColor = .white
        }

        let thirdViewController = with(WebPageViewController(urlString: "document")) {
            $0.tabBarItem = UITabBarItem(title: "Documents", image: .none, tag: 2)
            $0.view.backgroundColor = .white
        }

        let fourthViewController = with(WebPageViewController(urlString: "news")) {
            $0.tabBarItem = UITabBarItem(title: "Company News", image: .none, tag: 3)
            $0.view.backgroundColor = .white
        }

        let fifthViewController = with(WebPageViewController(urlString: "job-opening")) {
            $0.tabBarItem = UITabBarItem(title: "Job Openings", image: .none, tag: 4)
            $0.view.backgroundColor = .white
        }

        let sixthViewController = with(WebPageViewController(urlString: "events")) {
            $0.tabBarItem = UITabBarItem(title: "Calendar", image: .none, tag: 5)
            $0.view.backgroundColor = .white
        }

        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            fourthViewController,
            fifthViewController,
            sixthViewController
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
