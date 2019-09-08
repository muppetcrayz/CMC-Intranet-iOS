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
    var announcements: [String] = [
        "Announcement 1",
        "Announcement 2",
        "Announcement 3",
    ]
    
    var documents: [String] = [
        "Document 1",
        "Document 2"
    ]
    
    var companyNews: [String] = [
        "Company News 1",
        "Company News 2",
        "Company News 3"
    ]
    
    var jobOpenings: [String] = [
        "Job Openings 1",
        "Job Openings 2",
        "Job Openings 3",
    ]
    
    var calendarEvents: [String] = [
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
    
    func load() {
        with(UserDefaults.standard) {
            announcements = $0.array(forKey: "announcements") as? [String] ?? []
            documents = $0.array(forKey: "documents") as? [String] ?? []
            companyNews = $0.array(forKey: "companyNews") as? [String] ?? []
            jobOpenings = $0.array(forKey: "jobOpenings") as? [String] ?? []
            calendarEvents = $0.array(forKey: "calendarEvents") as? [String] ?? []
            
            favorites = $0.dictionary(forKey: "favorites") as? [String : Date] ?? [:]
            read = Set($0.array(forKey: "read") as? [String] ?? [])
        }
    }
    
    func save() {
        with(UserDefaults.standard) {
            $0.set(announcements, forKey: "announcements")
            $0.set(documents, forKey: "documents")
            $0.set(companyNews, forKey: "companyNews")
            $0.set(jobOpenings, forKey: "jobOpenings")
            $0.set(calendarEvents, forKey: "calendarEvents")
            
            $0.set(favorites, forKey: "favorites")
            $0.set(Array(read), forKey: "read")
        }
    }
}
