//
//  Caching.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/19/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

protocol Caching {}

extension Caching where Self: BaseObject {
    
    func save() {
        DispatchQueue.main.async {
            DatabaseManager.shared.save(objects: [self])
        }
    }
    
    // get all values from database
    static func cached() -> [Self] {
        return DatabaseManager.shared.getAll(type: self)
    }
    
    /// Update the object inside update handler
    func update(updateHandler: (Self) -> Void) {
        try? DatabaseManager.shared.database.write {
            updateHandler(self)
        }
    }
    
    
}

extension Array where Element: BaseObject {
    func saveAll() {
        DispatchQueue.main.async {
            DatabaseManager.shared.save(objects: self)
        }
    }
}
