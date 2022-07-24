//
//  AlertViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit

class AlertViewController: UIViewController {
    
    var tamagotchiImage: String? = nil
    var tamagotchiName: String? = nil
    var tamagotchiInfo: String? = nil

    static let identifier = "AlertViewController"
    
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    @IBOutlet weak var tamagotchiInfoLabel: UILabel!
    @IBOutlet weak var tamagotchiNameView: UIView!
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var line2Label: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        alertView.backgroundColor = DefaultDesign.backgroundColor
        
        lineLabel.text = nil
        lineLabel.layer.borderWidth = 1
        lineLabel.layer.borderColor = UIColor.systemGray4.cgColor
        lineLabel.textAlignment = .center
        
        line2Label.text = nil
        line2Label.layer.borderWidth = 1
        line2Label.layer.borderColor = UIColor.systemGray4.cgColor
        line2Label.textAlignment = .center
        
        tamagotchiImageView.image = UIImage(named: tamagotchiImage!)
        tamagotchiNameLabel.text = tamagotchiName
        tamagotchiInfoLabel.text = tamagotchiInfo
        
        tamagotchiInfoLabel.font = .systemFont(ofSize: DefaultDesign.fontSizeMin)
        tamagotchiInfoLabel.textColor = DefaultDesign.basicColor
        tamagotchiInfoLabel.textAlignment = .center
        tamagotchiInfoLabel.numberOfLines = 0
        
        
        designtNameView(view: tamagotchiNameView, label: tamagotchiNameLabel)
        
        designAlert()
        designButton()
        
    }
    
    func designAlert() {
        alertView.layer.cornerRadius = 5
        
    }
    
    func designButton() {
        cancleButton.setTitle("취소", for: .normal)
        cancleButton.setTitleColor(DefaultDesign.basicColor, for: .normal)
        cancleButton.backgroundColor = .systemGray5
        cancleButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMaxYCorner]
        cancleButton.layer.cornerRadius = 5
        
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(DefaultDesign.basicColor, for: .normal)
    }
    
    @IBAction func cancleButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: growingTamagotchiViewController.identifier) as! growingTamagotchiViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false)
    }
    
}
