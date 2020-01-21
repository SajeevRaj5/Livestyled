//
//  EventPresenterTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTest

class EventPresenterTests: QuickSpec {

    class MockInteractor: PresenterToInteractorEventProtocol {
        var presenter: InteractorToPresenterEventProtocol?
        let mockEvents = MockData.events
        var isEventFavourite = false
        
        func isEventFavorite(isFavorite: Bool, event: Event) {
            isEventFavourite = true
        }
        
        func fetchEventsForCriteria(text: String = "success") {
            if text == "success" {
                presenter?.onSuccessEventsFetch(events: mockEvents, totalEntriesCount: mockEvents.count)
            } else {
                presenter?.onFailedEventsFetch(error: NSError(domain: "test error", code: 123, userInfo: nil))
            }
        }
        
        func fetchEvents() {
            presenter?.onSuccessEventsFetch(events: mockEvents, totalEntriesCount: 0)
        }
        
    }
    
    class MockRouter: PresenterToRouterProtocol {
        var event : Event?
        static func createModule() -> EventListViewController {
            return EventListRouter.createModule()
        }
        
    }
    
    class MockView: PresenterToViewEventProtocol {
  
        var shouldShowEvents = false
        var shouldShowError = false
        var shoulddismissLoader = false
        var shouldFavoriteEvent = false

        func showError(error: Error) {
            shouldShowError = true
        }
        
        func dismissLoader() {
            shoulddismissLoader = true
        }
        
        func showEvents(events: [EventViewModel]) {
            shouldShowEvents = true
        }
    }
    
    var presenter: EventListPresenter!
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
    var mockEvents: [Event]!
    var mockView: MockView!
    
    override func spec() {
        
        beforeEach() {
            self.presenter = EventListPresenter()
            self.mockRouter = MockRouter()
            self.presenter?.router = self.mockRouter
            
            self.mockInteractor = MockInteractor()
            self.mockInteractor.presenter = self.presenter
            self.presenter?.interactor = self.mockInteractor
            
            self.mockView = MockView()
            self.presenter?.view = self.mockView
            self.mockEvents = MockData.events
        }
        
        describe("Events Fetch") {
            
            it("Should show the fetched events") {
                self.presenter.fetchAllEvents()
                expect(self.mockView.shouldShowEvents).to(equal(true))
            }
        }
        
        describe("Events favorite") {
            beforeEach() {
                self.presenter!.events = MockData.events
            }
            
            it("Should favorite event") {
                self.presenter.isFavoriteAction(isFavorite: true, index: 0)
                expect(self.mockInteractor.isEventFavourite).to(equal(true))
            }
        }
    }
}
