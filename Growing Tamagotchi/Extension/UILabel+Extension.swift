//
//  UILabel+Extension.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/25.
//

import Foundation
import UIKit

extension UILabel {
    func designLine() {
        self.text = nil
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func designPrintInfoLabel(text: String) {
        self.text = text
        self.textColor = DefaultDesign.basicColor
        self.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        self.textAlignment = .center
    }
}
