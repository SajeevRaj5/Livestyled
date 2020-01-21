//
//  DateExtension.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/18/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation

extension Date {
     func toString(_ mask:String?) -> String {
        let dateFormatter = DateFormatter()
        if mask != nil {
            dateFormatter.dateFormat = mask
        } else {
            dateFormatter.timeStyle = .medium
            dateFormatter.dateStyle = .medium
        }
        
        return dateFormatter.string(from: self)
    }
}
