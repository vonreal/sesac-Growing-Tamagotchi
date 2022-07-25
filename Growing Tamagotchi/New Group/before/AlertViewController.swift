//
//  AlertViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit

class AlertViewController: UIViewController {
    
    static let identifier = "AlertViewController"
    
    // 저장 속성(값 전달)
    var tamagotchiImage: String? = nil
    var tamagotchiName: String? = nil
    var tamagotchiInfo: String? = nil

    // 아울렛 변수
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    @IBOutlet weak var tamagotchiInfoLabel: UILabel!
        
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancleButton: UIButton!
    
    @IBOutlet var lineLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
    }
    
    // MARK: - [디자인]
    func designUI() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        alertView.backgroundColor = DefaultDesign.backgroundColor
        
        designLine()
        designAlert()
        designButton()
        
        designTamagotchi()
    }
    
    func designLine() {
        for label in lineLabels {
            label.designLine()
        }
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
    func designTamagotchi() {
        // 데이터 설정
        tamagotchiImageView.image = UIImage(named: tamagotchiImage!)
        tamagotchiNameLabel.text = tamagotchiName
        tamagotchiInfoLabel.text = tamagotchiInfo
        
        // 디자인
        tamagotchiInfoLabel.font = .systemFont(ofSize: DefaultDesign.fontSizeMin)
        tamagotchiInfoLabel.textColor = DefaultDesign.basicColor
        tamagotchiInfoLabel.textAlignment = .center
        tamagotchiInfoLabel.numberOfLines = 0
        
        designtNameView(view: tamagotchiNameView, label: tamagotchiNameLabel)
    }
    
    // MARK: - [클릭액션]
    @IBAction func cancleButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        // 세이브 포인트 설정
        UserDefaults.standard.set(true, forKey: SaveKey.save)
        
        // 다마고치 이름 저장
        UserDefaults.standard.set(tamagotchiNameLabel.text, forKey: SaveKey.tamagotchi)
        
        
        // 다마고치 변경에서 화면이 무한하게 쌓일 수 있기 때문에 루트뷰를 변경하도록 설정
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: growingTamagotchiViewController.identifier) as? growingTamagotchiViewController else { print("Not found \(growingTamagotchiViewController.identifier)"); return }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}
