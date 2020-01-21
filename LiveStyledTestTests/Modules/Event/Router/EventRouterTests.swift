//
//  EventRouterTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTestTests

class EventRouterTests: QuickSpec {
 
    override func spec() {
        
        var eventRouter: EventRouter!
        var event: Event!
        
        beforeEach() {
            eventRouter = EventRouter()
            event = Event()
        }
        
        describe("Should create the module and present") {
            
            it("should have presented EventDetailViewController") {
                let eventListViewController = EventRouter.createModule()
                expect(eventListViewController).to(beAKindOf(EventListViewController.self))

                expect(eventListViewController.presenter).toNot(beNil())
                expect(eventListViewController.presenter?.view).toNot(beNil())
                expect(eventListViewController.presenter?.interactor).toNot(beNil())
                expect(eventListViewController.presenter?.router).toNot(beNil())
            }
        }
    }

}
