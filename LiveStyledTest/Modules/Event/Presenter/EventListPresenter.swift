//
//  EventListPresenter.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import UIKit

typealias EventViewModel = (title:String, date:String, imageUrlString:String, isFavorite:Bool)

class EventListPresenter: ViewToPresenterEventProtocol {
    
    var events: [Event]?

    weak var view: PresenterToViewEventProtocol?
    
    var interactor: PresenterToInteractorEventProtocol?
    
    var router: PresenterToRouterProtocol?
    
    var page = 0
    var totalEntries = 0
    
    func fetchAllEvents() {
        interactor?.fetchEvents()
    }
    
    func fetchNextSetEvents(currentEventsCount: Int) {
        if currentEventsCount < totalEntries {
            interactor?.fetchEvents()
        }
    }
    
    func isFavoriteAction(isFavorite: Bool, index: Int) {
        guard let allEvents = events else { return }
        interactor?.isEventFavorite(isFavorite: isFavorite, event: allEvents[index])
    }
}

extension EventListPresenter: InteractorToPresenterEventProtocol {
    func onSuccessEventsFetch(events: [Event], totalEntriesCount: Int) {
        
        // initialise list with empty data if nil
        if self.events == nil {
            self.events = [Event]()
        }
        
        totalEntries = totalEntriesCount
        self.events?.append(contentsOf: events)
        var eventViewModels = [EventViewModel]()
        
        for event in events {
            let eventViewModel: EventViewModel = (event.artist, event.startDate, event.imageUrlString, event.isFavourite)
            eventViewModels.append(eventViewModel)
        }
        view?.showEvents(events: eventViewModels)
    }
    
    func onFailedEventsFetch(error: Error) {
        view?.showError(error: error)
    }
    
    func onServerResponseReceival() {
        view?.dismissLoader()
    }
}
