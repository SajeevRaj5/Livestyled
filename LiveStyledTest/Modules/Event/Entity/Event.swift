//
//  Event.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import UIKit

 class Event: BaseObject, Codable {
    
     @objc dynamic var id = ""
     @objc dynamic var artist = ""
     @objc dynamic var imageUrlString = ""
     @objc dynamic var startDate = ""
     @objc dynamic var isFavourite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case artist             = "title"
        case imageUrlString     = "image"
        case startDate          = "startDate"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        self.init()
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        id           = try container.decode(String.self, forKey: .id)
        artist      = try container.decode(String.self, forKey: .artist)
        imageUrlString            = try container.decode(String.self, forKey: .imageUrlString)
        
        let timeInterval = try container.decode(Int.self, forKey: .startDate)
        startDate = TimeInterval(timeInterval).getReadableDate() ?? ""
        
    }
    
    // MARK: - Encodable
     public func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(id, forKey: .id)
         try container.encode(artist, forKey: .artist)
         try container.encode(startDate, forKey: .startDate)
         try container.encode(imageUrlString, forKey: .imageUrlString)
     }
    
    static func fetchEvents(page: Int = 1, completion: @escaping (ServiceResponse<EventResponse>) -> ()) {
        
        Router.events(page: page).request { (response: ServiceResponse<EventResponse>) in
            switch response {
            case .success(let results):
                completion(.success(data: results))
            case .failure(let error):
                completion(.failure(error: error))
            case .finally:
                completion(.finally)
            }
        }
    }
}

extension Event {
    enum Router: Requestable {
        case events(page: Int)
        
        var path: String {
            switch self {
            case .events: return "events"
            }
        }
        
        var parameters: [String : String] {
            switch self {
            case .events(let page):
                return ["page": String(page)]
            }
        }
    }
}

extension Event {
    class EventResponse: Codable {
        var items = [Event]()
        var page = ""
        var pageSize = 0
        var total = 0
    }
}

