//
//  TimeIntervalExtensionTest.swift
//  LiveStyledTestTests
//
//  Created by sajeev Raj on 1/23/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//
import UIKit
import Quick
import Nimble
@testable import LiveStyledTest

class TimeIntervalExtensionTest: QuickSpec {
    
    override func spec() {
        describe("getReadableDate") {
            it("Should give tommorow") {
                let tomorrowTimeStamp =
                    Date().addingTimeInterval(60*60*24).timeIntervalSince1970
                expect( tomorrowTimeStamp.getReadableDate()).to( equal("Tomorrow"))
            }
            it("Should give tommorow") {
                let tomorrowTimeStamp =
                    Date().addingTimeInterval(-60*60*24).timeIntervalSince1970
                expect( tomorrowTimeStamp.getReadableDate()).to( equal("Yesterday"))
            }
        }

        
        describe("dateFallsInCurrentWeek") {
            
            it("Should dateFallsInCurrentWeek") {
                expect(Date().timeIntervalSince1970.dateFallsInCurrentWeek(date: Date())).to(equal(true))
            }
        }
    }
}
