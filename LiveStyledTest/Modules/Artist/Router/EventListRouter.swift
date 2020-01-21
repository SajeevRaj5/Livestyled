//
//  EventListRouter.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import UIKit

class EventListRouter: PresenterToRouterProtocol {
    static func createModule() -> EventListViewController {
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: EventListViewController.identifier) as? EventListViewController else { return EventListViewController() }
        
        var presenter: ViewToPresenterEventProtocol & InteractorToPresenterEventProtocol = EventListPresenter()
        var interactor: PresenterToInteractorEventProtocol = EventListInteractor()
        let router: PresenterToRouterProtocol = EventListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    
}
