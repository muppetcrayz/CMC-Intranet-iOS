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
    
    let documents: [TitleAndReadViewModel] = [
        .init(read: true, title: "Document 1"),
        .init(read: false, title: "Document 2")
    ]
    
    let companyNews: [TitleAndReadViewModel] = [
        .init(read: false, title: "Company News 1"),
        .init(read: false, title: "Company News 2"),
        .init(read: true, title: "Company News 3"),
    ]
    
    let jobOpenings: [TitleAndReadViewModel] = [
        .init(read: true, title: "Job Openings 1"),
        .init(read: true, title: "Job Openings 2"),
        .init(read: false, title: "Job Openings 3"),
    ]
    
    let calendarEvents: [TitleAndReadViewModel] = [
        .init(read: false, title: "Calendar Event 1"),
        .init(read: true, title: "Calendar Event 2"),
        .init(read: true, title: "Calendar Event 3"),
    ]
    
    var favorites: [TitleAndReadViewModel : Date] = [:]
}
