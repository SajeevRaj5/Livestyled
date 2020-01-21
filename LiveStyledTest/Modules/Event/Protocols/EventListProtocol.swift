//
//  EventListProtocol.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterEventProtocol {
    var view: PresenterToViewEventProtocol? {get set}
    var interactor: PresenterToInteractorEventProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    var events: [Event]? {get set}
    
    func fetchAllEvents()
    func fetchNextSetEvents(currentEventsCount: Int)
    func isFavoriteAction(isFavorite: Bool, index: Int)
}

protocol PresenterToViewEventProtocol: class {
    func showEvents(events: [EventViewModel])
    func showError(error: Error)
    func dismissLoader()
}

protocol PresenterToInteractorEventProtocol {
    var presenter: InteractorToPresenterEventProtocol? {get set}
    func fetchEvents()
    func isEventFavorite(isFavorite: Bool, event: Event)
}

protocol InteractorToPresenterEventProtocol: class {
    func onSuccessEventsFetch(events: [Event], totalEntriesCount: Int)
    func onFailedEventsFetch(error: Error)
    func onServerResponseReceival()
}

protocol PresenterToRouterProtocol {
    static func createModule() -> EventListViewController
}
