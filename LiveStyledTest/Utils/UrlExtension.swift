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
    func image(completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: self) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
