//
//  Constants.swift
//  CMC Intranet
//
//  Created by Sage Conger on 8/27/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import WebKit

let baseURLString = "http://intranet.cmcmmi.com/"

let processPool = WKProcessPool()
let configuration = with(WKWebViewConfiguration()) {
    $0.websiteDataStore = .default()
    $0.processPool = processPool
}
