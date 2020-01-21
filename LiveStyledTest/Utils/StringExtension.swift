//
//  StringExtension.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/18/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String? = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func eventFormatDate() -> String {
       return toDate()?.toString("MM/dd/yyyy") ?? ""
    }
}
