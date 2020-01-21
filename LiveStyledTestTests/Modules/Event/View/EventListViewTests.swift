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
            viewController = EventListRouter.createModule()
            presenter = MockPresenter()
            viewController?.presenter = presenter
            _ = viewController?.view
        }
        
        describe("Check if loaded") {
            
            it("Should load view") {
                expect(viewController?.title).toNot(beNil())
            }
            
            it("Should fetch values") {
                expect(presenter?.didfetchAllEvents).to(equal(true))
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
                viewController?.eventListData = [ MockData.eventsViewModel]
            }
            
            it("Should refresh view") {
                expect(viewController?.tableView.numberOfRows(inSection: 0)).to(equal(viewController?.eventListData.count ?? 0))
            }
        }
        
        describe("Pagination") {
            
            beforeEach() {
                viewController?.eventListData = [ MockData.eventsViewModel]
                let indexPath = IndexPath(row: (viewController?.eventListData.count ?? 0 ) - 1, section: 0)
                viewController?.isDataLoading = false
                viewController!.tableView!.delegate!.tableView?( viewController!.tableView, willDisplay: UITableViewCell( style: .default, reuseIdentifier: EventListViewCell.identifier), forRowAt: indexPath)
            }
            
            it("Should load next page") {
                expect(presenter?.didStartFetchingNextSetEvents).to(equal(true))
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
        didfetchAllEvents = true
    }
    
    func fetchNextSetEvents(currentEventsCount: Int) {
        didStartFetchingNextSetEvents = true
    }
    
    func isFavoriteAction(isFavorite: Bool, index: Int) {
        didFavoriteEvent = true
    }
}
