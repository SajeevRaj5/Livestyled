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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // set corner radius
        iconImageView?.layer.cornerRadius = (iconImageView?.frame.size.width ?? 0)/2
    }
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        favoriteActionHandler?(sender.isSelected)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(event: EventViewModel) {
        
        titleLabel?.text = event.title
        dateLabel?.text = event.date
        favoriteButton?.isSelected = event.isFavorite
        guard let url = URL(string: event.imageUrlString) else { return }
        url.image { [weak self] (image) in
            self?.iconImageView?.image = image
        }
    }
    
}
