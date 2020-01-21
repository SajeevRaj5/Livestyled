//
//  UrlExtension.swift
//  LiveStyledTest
//
//  Created by sajeev Raj on 1/18/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    func image(completion: @escaping ((UIImage) -> Void)) {
        let data = try? Data(contentsOf: self)
        
        if let imageData = data, let image = UIImage(data: imageData) {
            completion(image)
        }
    }
}
