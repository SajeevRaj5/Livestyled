//
//  CachingTests.swift
//  LiveStyledTestTests
//
//  Created by sajeev Raj on 1/23/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import Realm
@testable import LiveStyledTest

class CachingTests: QuickSpec {
    
    override func spec() {
        describe("Save event") {
            beforeEach() {
                MockData.events.first?.save()
            }
            
            it ("Should save all events") {
                expect(MockEvent.cached().count).to(equal(1))
            }
        }
    }
}
    
extension Caching where Self: BaseObject {

    func save() {
        MockDataBaseManager.shared.save(objects: [self])
    }

    // get all values from database
    static func cached() -> [Self] {
        return MockDataBaseManager.shared.getAll(type: self)
    }

    /// Update the object inside update handler
    func update(updateHandler: (Self) -> Void) {
        try? MockDataBaseManager.shared.database.write {
            updateHandler(self)
        }
    }
}

extension Array where Element: BaseObject {
    func saveAll() {
        MockDataBaseManager.shared.save(objects: self)
    }
}
