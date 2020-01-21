//
//  EventListViewController.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import UIKit

class EventListViewController: UITableViewController, ActivityIndicatorPresenter {
    var activityIndicator = UIActivityIndicatorView()
    
    var presenter: ViewToPresenterEventProtocol?
    
    // to check if service is in progress
    var isDataLoading: Bool = false
    
    var eventListData = [EventViewModel]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"

        // register tableview cell
        registerCell()
        
        showLoader()
        
        isDataLoading = true
        
        // fetch all events
        presenter?.fetchAllEvents()        
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: EventListViewCell.identifier, bundle: nil), forCellReuseIdentifier: EventListViewCell.identifier)
    }

}

// Tableview delegates
extension EventListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let eventCell = tableView.dequeueReusableCell(withIdentifier: EventListViewCell.identifier, for: indexPath) as? EventListViewCell else { return UITableViewCell() }
        eventCell.configureView(event: eventListData[indexPath.row])
        eventCell.favoriteActionHandler = { [weak self] isFavorite in
            self?.eventListData[indexPath.row].isFavorite = isFavorite
            self?.presenter?.isFavoriteAction(isFavorite: isFavorite, index: indexPath.row)
        }
        return eventCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // if user scroll to last 3 data in the list, start fetching the next list from next page
        guard (indexPath.row == eventListData.count - 1), !isDataLoading else { return }
        presenter?.fetchNextSetEvents(currentEventsCount: eventListData.count)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension EventListViewController: PresenterToViewEventProtocol {
    func showEvents(events: [EventViewModel]) {
        eventListData += events
    }
    
    func showError(error: Error) {
        AlertController.show(type: .serviceError)
    }
    
    func dismissLoader() {
        isDataLoading = false
        
        hideLoader()
    }
    
    
}
