//
//  ViewController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 7/22/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    let webView: WKWebView = {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        return WKWebView(frame: .zero, configuration: configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        with(webView) {
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            let url = "http://intranet.cmcmmi.com"
            let request = URLRequest(url: URL(string: url)!)
            
            $0.load(request)
            $0.navigationDelegate = self
            $0.uiDelegate = self
            
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalTo(view)
            }
        }
    }

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

