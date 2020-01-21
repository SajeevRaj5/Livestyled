//
//  MockData.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import RealmSwift
@testable import LiveStyledTest

class MockData {
    
    static let events = [MockEvent(id: "1", startDate: "12 Friday", artist: "Artist1", imageUrlString: ""),MockEvent(id: "2", startDate: "13 Friday", artist: "Artist2", imageUrlString: "") ]
    
    static let eventsResponse = [MockEvent.EventResponse(items: events,page: "0", pageSize:0,total: 0)]
    
    static let eventsViewModel = (title:"Artist1", date:"12 Friday", imageUrlString:"", isFavorite:true)
}

class MockEvent: Event {}

extension MockEvent {
    convenience init(id: String, startDate: String, artist: String, imageUrlString: String) {
        self.init()
        self.id = id
        self.startDate = startDate
        self.artist = artist
        self.imageUrlString = imageUrlString
    }
}

extension Event.EventResponse {
    convenience init(items: [Event], page: String, pageSize: Int, total: Int) {
        self.init()
        self.items = items
        self.page = page
        self.pageSize = pageSize
        self.total = total
    }
}
