//
//  EventListInteractor.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation

class EventListInteractor: PresenterToInteractorEventProtocol {
    
    var presenter: InteractorToPresenterEventProtocol?
    var totalEntries = 0
    var nextPage = 0
    
    func fetchEvents() {
        // check for network connection
        if Reachability.isConnectedToNetwork() {
            
            // fetch events from server
            Event.fetchEvents(page: nextPage) { [weak self]  (response) in
                guard let welf = self else { return }

                switch response {
                case .success(let response):
                    
                    welf.nextPage = (Int(response.page) ?? 0) + 1
                    welf.totalEntries = response.total
                    
                    let events = response.items
                    
                    // save events to database
                    DispatchQueue.main.async {
                        let updatedEvents = welf.updatedEventsBasedOnFavorite(newEvents: events)
                        updatedEvents.saveAll()
                        
                        // send events to presenter
                        welf.presenter?.onSuccessEventsFetch(events: updatedEvents, totalEntriesCount: welf.totalEntries)
                    }
                    
                case .failure(let error):
                    welf.presenter?.onFailedEventsFetch(error: error)
                case .finally:
                    welf.presenter?.onServerResponseReceival()
                }
            }
        }
        else {
            // fetch events from database
            presenter?.onServerResponseReceival()
            presenter?.onSuccessEventsFetch(events: Event.cached(), totalEntriesCount: Event.cached().count)
        }
    }
    
    func isEventFavorite(isFavorite: Bool, event: Event) {
        event.update { (event) in
            event.isFavourite = isFavorite
        }
    }
    
    // this method checks if the data is already cached, the favorited property is copied to the new events model. This is done as there is no service to update the favorite value to the server.
    func updatedEventsBasedOnFavorite(newEvents: [Event]) -> [Event] {
        for (cache, new) in zip(Event.cached(), newEvents) {
            if cache.id == new.id {
                new.isFavourite = cache.isFavourite
            }
        }
        return newEvents
    }
    
}
