//
//  GlobalState.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import Foundation
import SwiftyJSON

var globalState = GlobalState()

struct Post: Codable, Hashable {
    enum ContentType: String, Codable {
        case rawHTML
        case link
    }
    
    let title: String
    let content: String
    let type: ContentType
    
    init(dictionary: JSON, endpoint: Endpoint) {
        switch endpoint {
        case .calendarEvents:
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateStyle = .full
            outputDateFormatter.timeStyle = .short
            
            self.title = dictionary["title"].stringValue.htmlDecoded
            self.content = [
                "Description: \(dictionary["description"].stringValue)",
                "Start: \(outputDateFormatter.string(from: inputDateFormatter.date(from: dictionary["start_date"].stringValue)!))",
                "End: \(outputDateFormatter.string(from: inputDateFormatter.date(from: dictionary["end_date"].stringValue)!))"
            ].joined(separator: "<br><br>")
            self.type = .rawHTML
            
        case .documents:
            self.title = dictionary["title"]["rendered"].stringValue.htmlDecoded
            self.content = dictionary["toolset-meta"]["documents"]["document"]["raw"][0].stringValue
            self.type = .link
            
        default:
            self.title = dictionary["title"]["rendered"].stringValue.htmlDecoded
            self.content = dictionary["content"].dictionaryValue["rendered"]!.stringValue
            self.type = .rawHTML
        }
    }
}

class GlobalState {
    var announcements: [Post] = []
    
    var documents: [Post] = []
    
    var companyNews: [Post] = []
    
    var jobOpenings: [Post] = []
    
    var calendarEvents: [Post] = []
    
    var favorites: [Post : Date] = [:]
    
    var read: Set<Post> = []
    
    func load() {
        with(UserDefaults.standard) {
            if let data = $0.object(forKey: "favorites") as? Data,
                let decoded = try? PropertyListDecoder().decode([Post : Date].self, from: data) {
                favorites = decoded
            }
            
            if let data = $0.object(forKey: "read") as? Data,
                let decoded = try? PropertyListDecoder().decode([Post].self, from: data) {
                read = Set(decoded)
            }
        }
    }
    
    func save() {
        with(UserDefaults.standard) {
            try! $0.set(PropertyListEncoder().encode(favorites), forKey: "favorites")
            try! $0.set(PropertyListEncoder().encode(read), forKey: "read")
        }
    }
    
    func loadRemoteData(endpoint: Endpoint) {
        let urlString: String
        switch endpoint {
        case .calendarEvents:
            urlString = baseURLString + "/wp-json/tribe/events/v1/events"
            
        default:
            urlString = baseURLString + "/wp-json/wp/v2/\(endpoint.rawValue)"
        }
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try! JSON(data: data)
                let jsonArray: [JSON]
                
                switch endpoint {
                case .calendarEvents:
                    jsonArray = json["events"].arrayValue
                    
                default:
                    jsonArray = json.arrayValue
                }
                let posts = jsonArray.map { Post(dictionary: $0, endpoint: endpoint) }
                
                switch endpoint {
                case .announcements:
                    self.announcements = posts
                    
                case .documents:
                    self.documents = posts
                    
                case .companyNews:
                    self.companyNews = posts
                    
                case .jobOpenings:
                    self.jobOpenings = posts
                    
                case .calendarEvents:
                    self.calendarEvents = posts
                }
                
                print(json)
            }
        }
        task.resume()
    }
}

enum Endpoint: String {
    case announcements = "announcement"
    case documents = "document"
    case companyNews = "posts"
    case jobOpenings = "job-opening"
    case calendarEvents
}
