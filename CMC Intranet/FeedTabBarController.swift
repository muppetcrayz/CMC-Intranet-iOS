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

        var newViewControllers: [UIViewController] = []
        
        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.favorites.sorted(by: {
                $0.value > $1.value
            })
            .map { $0.key }
        })) {
            $0.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "tab_favorites"), tag: 0)
        })
        
        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.announcements
        })) {
            $0.tabBarItem = UITabBarItem(title: "Announcements", image: UIImage(named: "tab_announcements"), tag: 1)
        })

        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.documents
        })) {
            $0.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(named: "tab_documents"), tag: 2)
        })

        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.companyNews
        })) {
            $0.tabBarItem = UITabBarItem(title: "Company News", image: UIImage(named: "tab_company"), tag: 3)
        })

        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.jobOpenings
        })) {
            $0.tabBarItem = UITabBarItem(title: "Job Openings", image: UIImage(named: "tab_jobs"), tag: 4)
        })

        newViewControllers.append(with(TitleAndReadViewController(globalStateSelector: {
            $0.calendarEvents
        })) {
            $0.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "tab_calendar"), tag: 5)
        })
        
        viewControllers = newViewControllers

        navigationItem.rightBarButtonItem = UIBarButtonItem(
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
