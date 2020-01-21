//
//  MockData.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import RealmSwift
@testable import LiveStyledTestTests

class MockEvent {
    
    static let events = [Event(id: "123", startDate: "12 Friday", artist: "test", imageUrlString: "") ]
}

extension Event {
    convenience init(title: String, shortTitle: String, date:String, url: String,venue: Venue, performers: [Performer]) {
        self.init()
        self.title       = title
        self.shortTitle  = shortTitle
        self.date        = shortTitle
        self.url         = url
        self.venue       = venue
        performers.forEach { (performer) in
            self.performers.append(performer)
        }
    }
}
