//
//  DatabaseManager.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/19/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    var database: Realm
    
    static let shared = DatabaseManager()
    
    private init() {
        database = try! Realm()
    }
    
    // For unit testing
    init(database: Realm) {
        self.database = database
    }
    
    func getAll<T>(type: Object.Type) -> [T] {
        return (Array(database.objects(type)) as? [T]) ?? []
    }
    
    func save(objects: [Object], update: Bool = true) {
        try! database.write {
            database.add(objects, update: .modified)
        }
    }

    func removeAll(type: Object.Type) {
        let objects = database.objects(type)
        try! database.write {
            database.delete(objects)
        }
    }
}
