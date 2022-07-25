//
//  DefaultDesign.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit

struct DefaultDesign {
    static let backgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
    static let basicColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
    static let fontSizeMin = 13.0
    static let fontSizeMedium = 14.0
    static let fontSizeMax = 15.0
    static let foodButtonIcon = "drop.circle"
    static let waterButtonIcon = "leaf.circle"
    static let oepnSettingButtonIcon = "person.circle"
}

func designtNameView(view: UIView, label: UILabel) {
    label.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
    label.textAlignment = .center
    label.textColor = DefaultDesign.basicColor
    
    view.layer.borderColor = DefaultDesign.basicColor.cgColor
    view.layer.borderWidth = 0.5
    view.layer.cornerRadius = 5
    view.backgroundColor = DefaultDesign.backgroundColor
}
