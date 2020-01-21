//
//  EventListRouterTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTest

class EventListRouterTests: QuickSpec {
 
    override func spec() {
        
        var eventRouter: EventListRouter!
        var event: Event!
        
        beforeEach() {
            eventRouter = EventListRouter()
            event = Event()
        }
        
        describe("Router module creation") {
            
            it("Should create the event list module") {
                let eventListViewController = EventListRouter.createModule()
                expect(eventListViewController).to(beAKindOf(EventListViewController.self))

                expect(eventListViewController.presenter).toNot(beNil())
                expect(eventListViewController.presenter?.view).toNot(beNil())
                expect(eventListViewController.presenter?.interactor).toNot(beNil())
                expect(eventListViewController.presenter?.router).toNot(beNil())
            }
        }
    }

}
