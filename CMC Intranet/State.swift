//
//  State.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import Foundation

var state = State()

class State {
    let announcements: [TitleAndReadViewModel] = [
        .init(read: false, title: "Announcement 1"),
        .init(read: true, title: "Announcement 2"),
        .init(read: false, title: "Announcement 3"),
    ]
    
    var favorites: [TitleAndReadViewModel : Date] = [:]
}
