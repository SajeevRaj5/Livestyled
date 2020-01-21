//
//  TimeIntervalExtension.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/18/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation

extension TimeInterval {
    func getReadableDate() -> String? {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE h:mm"
                return dateFormatter.string(from: date)
            }
        } else {
            dateFormatter.dateFormat = "h:mm a, MMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }
}
