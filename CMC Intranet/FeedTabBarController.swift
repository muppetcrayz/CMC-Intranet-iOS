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

        let firstViewController = with(WebPageViewController(urlString: "\(baseURLString)/announcement/")) {
            $0.tabBarItem = UITabBarItem(title: "Announcements", image: UIImage(named: "tab_announcements"), tag: 0)
            $0.view.backgroundColor = .white
        }

        let secondViewController = with(WebPageViewController(urlString: "\(baseURLString)/document/")) {
            $0.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(named: "tab_documents"), tag: 1)
            $0.view.backgroundColor = .white
        }

        let thirdViewController = with(WebPageViewController(urlString: "\(baseURLString)/news/")) {
            $0.tabBarItem = UITabBarItem(title: "Company News", image: UIImage(named: "tab_company"), tag: 2)
            $0.view.backgroundColor = .white
        }

        let fourthViewController = with(WebPageViewController(urlString: "\(baseURLString)/job-opening/")) {
            $0.tabBarItem = UITabBarItem(title: "Job Openings", image: UIImage(named: "tab_jobs"), tag: 3)
            $0.view.backgroundColor = .white
        }

        let fifthViewController = with(WebPageViewController(urlString: "\(baseURLString)/events/")) {
            $0.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "tab_calendar"), tag: 4)
            $0.view.backgroundColor = .white
        }

        viewControllers = [
            firstViewController,
            secondViewController,
            thirdViewController,
            fourthViewController,
            fifthViewController
        ]
    }
}
