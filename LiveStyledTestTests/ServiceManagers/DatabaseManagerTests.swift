//
//  DatabaseManagerTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import RealmSwift
import Quick
import Nimble

@testable import SeatGeek

class MockObject: Object {}

class MockDataBaseManager: DatabaseManager {

    init() {
        let database = try! Realm()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "LiveStyledTest"
        super.init(database: database)
    }
}

