//
//  EventListViewTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTest

class EventListViewControllerTest: QuickSpec {
    
    override func spec() {
        var viewController: EventListViewController?
        var presenter: MockPresenter?
        
        beforeEach() {
            viewController = EventRouter.createModule()
            presenter = MockPresenter()
            viewController?.presenter = presenter
            _ = viewController?.view
        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                expect(viewController?.title).toNot(beNil())
            }
        }
        
        describe("Check if no data recived ") {

               beforeEach() {
                   viewController?.eventListData = []
               }
               
               it("Should display empty view") {
               expect(viewController?.tableView.numberOfRows(inSection: 0)).to(equal(0))
               }
           }
        
        describe("Check if recived data is displayed") {
            
            beforeEach() {
                viewController?.eventListData = MockEvent.events
            }
            
            it("Should refresh view") {
                expect(viewController?.tableView.numberOfRows(inSection: 0)).to(equal(viewController?.eventListData.count ?? 0))
            }
        }
    }

}

class MockPresenter: ViewToPresenterEventProtocol {
    
    var didfetchAllEvents = false
    var didFavoriteEvent = false
    var didStartFetchingNextSetEvents = false
    
    var view: PresenterToViewEventProtocol?
    var interactor: PresenterToInteractorEventProtocol?
    var router: PresenterToRouterProtocol?
    var events: [Event]?
    
    func fetchAllEvents() {
        didStartFiltering = true
    }
    
    func fetchNextSetEvents(currentEventsCount: Int) {
        didStartFetchingNextSetEvents = true
    }
    
    func isFavoriteAction(isFavorite: Bool, index: Int) {
        didFavoriteEvent = true
    }
}
