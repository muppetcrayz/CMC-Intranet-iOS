//
//  DetailViewController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    let globalStateSelector: (GlobalState) -> Post
    
    init(globalStateSelector: @escaping (GlobalState) -> Post) {
        self.globalStateSelector = globalStateSelector
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        with(webView) {
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(view.safeAreaLayoutGuide)
            }
        }
        
        let viewModel = globalStateSelector(globalState)
        title = viewModel.title
        
        switch viewModel.type {
        case .link:
            webView.load(URLRequest(url: URL(string: viewModel.content)!))
            
        case .rawHTML:
            var htmlString = ""
            
            htmlString.append("<style>body { font-size: 45px; font-family: sans-serif; }</style>")
            htmlString.append(globalStateSelector(globalState).content)
            
            webView.loadHTMLString(htmlString, baseURL: .none)
        }
    }
}
