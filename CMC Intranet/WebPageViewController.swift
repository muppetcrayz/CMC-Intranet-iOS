//
//  WebPageViewController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 8/27/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
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
            
            let request = URLRequest(url: url)
            $0.loadRequest(request)
        }
    }
}
