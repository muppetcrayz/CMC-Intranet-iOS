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
    
    let url: String

    init(urlString: String) {
        self.url = urlString
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        var request = URLRequest(url: URL(string: baseURLString + "/wp-json/")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data)
                print(json)
            }
        }
        task.resume()
        
    }
    

//
//    let webView = UIWebView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        with(webView) {
//            view.addSubview($0)
//
//            $0.snp.makeConstraints {
//                $0.edges.equalTo(view.safeAreaLayoutGuide)
//            }
//
//            let request = URLRequest(url: url)
//            $0.loadRequest(request)
//        }
//    }
}
