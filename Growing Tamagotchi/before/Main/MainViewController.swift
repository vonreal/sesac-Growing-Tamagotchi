//
//  MainViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit

class MainViewController: UINavigationController {
    
    static let identifier = "MainViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(returnmain))
    }
    
    @objc func returnmain() {
        print("returnmain")
    }
}
