//
//  UITextField+Extension.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/25.
//

import Foundation
import UIKit

extension UITextField {
    func designTextField(placeholder: String) {
        self.placeholder = placeholder
        self.borderStyle = .none
        self.textAlignment = .center
        self.keyboardType = .numberPad
    }
}
