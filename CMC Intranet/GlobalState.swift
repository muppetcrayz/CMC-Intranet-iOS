//
//  GlobalState.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import Foundation

var globalState = GlobalState()

class GlobalState {
    let announcements: [String] = [
        "Announcement 1",
        "Announcement 2",
        "Announcement 3",
    ]
    
    let documents: [String] = [
        "Document 1",
        "Document 2"
    ]
    
    let companyNews: [String] = [
        "Company News 1",
        "Company News 2",
        "Company News 3"
    ]
    
    let jobOpenings: [String] = [
        "Job Openings 1",
        "Job Openings 2",
        "Job Openings 3",
    ]
    
    let calendarEvents: [String] = [
        "Calendar Event 1",
        "Calendar Event 2",
        "Calendar Event 3",
    ]
    
    var favorites: [String : Date] = [:]
    var read: Set<String> = [
        "Announcement 2",
        "Document 1",
        "Company News 3"
    ]
}
