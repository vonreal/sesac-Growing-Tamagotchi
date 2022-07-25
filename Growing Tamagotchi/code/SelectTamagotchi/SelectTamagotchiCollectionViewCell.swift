//
//  SelectTamagotchiCollectionViewCell.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit

class SelectTamagotchiCollectionViewCell: UICollectionViewCell {
    static let identifier = "SelectTamagotchiCollectionViewCell"
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
}
