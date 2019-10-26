//
//  WebPageViewController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 8/27/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    let url: URL
    
    init(urlString: String) {
        self.url = URL(string: urlString)!
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        with(webView) {
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(view.safeAreaLayoutGuide)
            }
            
            $0.delegate = self
            
            let request = URLRequest(url: url)
            $0.loadRequest(request)
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if let url = request.url {
            print("***", url)
        }
        
        if request.url?.lastPathComponent == "/"
        {
            navigationController?.pushViewController(FeedTabBarController(), animated: true)
            UserDefaults.standard.set(true, forKey: "loggedIn")
            let cookieJar: HTTPCookieStorage = HTTPCookieStorage.shared
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: cookieJar.cookies)
            let ud: UserDefaults = UserDefaults.standard
            ud.set(data, forKey: "cookie")
        }
        
        return true
    }
}
