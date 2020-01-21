//
//  EventListViewCell.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/17/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import UIKit

class EventListViewCell: UITableViewCell {
    typealias FavoriteActionHandler = (Bool) -> ()
    var favoriteActionHandler: FavoriteActionHandler?

    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var iconImageView: UIImageView?
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        favoriteActionHandler?(sender.isSelected)
    }
    
    func configureView(event: EventViewModel) {
        
        titleLabel?.text = event.title
        dateLabel?.text = event.date
        favoriteButton?.isSelected = event.isFavorite
        guard let url = URL(string: event.imageUrlString) else { return }
        url.image { [weak self] (image) in
            guard let eventImage = image else { return }
            self?.iconImageView?.circle(image: eventImage)
        }
    }
    
}
