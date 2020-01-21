//
//  RequestableTests.swift
//  LiveStyledTestTests
//
//  Created by sajeev Raj on 1/20/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTest

class RequestableTests: QuickSpec {
    
    override func spec() {
        
        var mockRequestable:  MockRequestable?
        
        beforeEach() {
            mockRequestable = MockRequestable()
        }
        
        describe("Check if loaded") {
            it ("") {
                let requestExpectation = XCTestExpectation(description: "Network request expectation")
                mockRequestable?.request(completion: { (test: ServiceResponse<Event>) in
                    requestExpectation.fulfill()
                })
            }
        }
    }
    
    class MockRequestable: Requestable {
        var path: String {
            return "www.google.com"
        }
        
        var parameters: [String : String] {
            return [:]
        }
        
        var queryItems: [(queryName: String, queryValue: String)] {
            return []
        }
        
        var queryParameters: [(queryName: String, queryValue: String)]? {
            return nil
        }
    }
}
