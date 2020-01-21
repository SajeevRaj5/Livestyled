//
//  EventPresenterTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTestTests

class EventPresenterTests: QuickSpec {

    class MockInteractor: PresenterToInteractorEventProtocol {
        let mockEvents = MockEvent.events

        var presenter: InteractorToPresenterEventProtocol?
        
        func fetchEventsForCriteria(text: String = "success") {
            if text == "success" {
                presenter?.onSuccessEventsFetch(events: mockEvents)
            } else {
                presenter?.onFailedEventsFetch(error: NSError(domain: "test error", code: 123, userInfo: nil))
            }
        }
        
        func fetchEvents() {
            presenter?.onSuccessEventsFetch(events: mockEvents)
        }
        
    }
    
    class MockRouter: PresenterToRouterProtocol {
        var event : Event?
        static func createModule() -> EventListViewController {
            return EventRouter.createModule()
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
    }
    
    var presenter: EventPresenter!
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!
    var mockEvents: [Event]!
    var mockView: MockView!
    
    override func spec() {
        
        beforeEach() {
            self.presenter = EventPresenter()
            self.mockRouter = MockRouter()
            self.presenter?.router = self.mockRouter
            
            self.mockInteractor = MockInteractor()
            self.mockInteractor.presenter = self.presenter
            self.presenter?.interactor = self.mockInteractor
            
            self.mockView = MockView()
            self.presenter?.view = self.mockView
            self.mockEvents = MockEvent.events
        }
        
        describe("Events Fetch") {
            
            it("Should show the fetched events") {
                self.presenter.fetchAllEvents()
                expect(self.mockView.shouldShowEvents).to(equal(true))
            }
        }
        
        describe("Events favorite") {
            
            it("Should favorite event") {
                self.presenter.isFavoriteAction(isFavorite: true, index: indexPath.row)
                expect(self.mockView.shouldFavoriteEvent).to(equal(true))
            }
        }
    }
}
