//
//  UIButton+Extension.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/25.
//

import Foundation
import UIKit

extension UIButton {
    func designEatButton(title: String, imageName: String) {
        self.tintColor = DefaultDesign.basicColor
        self.setImage(UIImage(systemName: imageName), for: .normal)
        self.setTitle(title, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = DefaultDesign.basicColor.cgColor
        self.layer.cornerRadius = 5
    }
}
