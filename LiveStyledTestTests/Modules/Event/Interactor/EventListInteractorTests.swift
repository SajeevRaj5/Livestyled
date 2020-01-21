//
//  EventListInteractorTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
//func onSuccessEventsFetch(events: [Event], totalEntriesCount: Int)
//func onFailedEventsFetch(error: Error)
//func onServerResponseReceival()

import Quick
import Nimble
@testable import LiveStyledTest

class EventListInteractorTests: QuickSpec {

    class MockPresenter: InteractorToPresenterEventProtocol {
        var mockEvents = [Event]()
        var error: Error?
        var didonServerResponseReceival = false
        
        func onSuccessEventsFetch(events: [Event], totalEntriesCount: Int) {
            mockEvents = MockData.events
        }
        
        func onFailedEventsFetch(error: Error) {
            self.error = error
        }
        
        func onServerResponseReceival(){
            didonServerResponseReceival = true
        }
    }
    
    override func spec() {

        var presenter: MockPresenter!
        var interactor: EventListInteractor!

        describe("Events Fetch") {
            
            beforeEach() {
                interactor = EventListInteractor()
                presenter = MockPresenter()
                interactor.presenter = presenter
                interactor!.fetchEvents()
            }
            
            it("Should show the fetched events") {
                interactor.fetchEvents()
            }
            
            describe("Events Favourite") {
                
                let event = MockData.events.first!
                beforeEach() {
                    event.save()
                    interactor.isEventFavorite(isFavorite: true, event: event)
                }
                
                it("Should update event as favourite") {
                    expect(MockEvent.cached().first?.isFavourite).to(equal(true))
                }
            }
        }
    }
}
