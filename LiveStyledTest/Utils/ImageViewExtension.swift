//
//  ImageViewExtension.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/22/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import UIKit

extension UIImageView {
  public func circle(image: UIImage) {
    contentMode = UIView.ContentMode.scaleAspectFill
    layer.cornerRadius = frame.height / 2
    layer.masksToBounds = false
    clipsToBounds = true
    self.image = image
  }
}
