//
//  UIImageView + Extension.swift
//  RadioApp
//
//  Created by Алексей on 07.08.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func getImage(from url: URL?) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(1))
            ]
        )
    }
}
