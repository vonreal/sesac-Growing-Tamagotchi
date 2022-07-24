//
//  growingTamagotchiViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/24.
//

import UIKit
import Toast

class growingTamagotchiViewController: UIViewController {

    static let identifier = "growingTamagotchiViewController"
    
    @IBOutlet weak var speechBubleImageView: UIImageView!
    @IBOutlet weak var speechBubbleContentLabel: UILabel!
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    
    @IBOutlet var midPointLabels: [UILabel]!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var riceCountLabel: UILabel!
    @IBOutlet weak var waterCountLabel: UILabel!
    
    @IBOutlet var clearBackgroundViewCollection: [UIView]!
    
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet var lineLabelCollection: [UILabel]!
    
    @IBOutlet weak var ricebutton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    
    @IBOutlet weak var mainview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [네비게이션 아이템 바]
        // 0. 네비게이션 타이틀
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        navigationItem.title = "\(nickname ?? "고래밥")님의 다마고치"
        
        // 1. 네비게이션 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(openSetting))
        
        
        // [UI 디자인]
        // 0. 배경색
        view.backgroundColor = DefaultDesign.backgroundColor
        
        for view in clearBackgroundViewCollection {
            view.backgroundColor = .clear
        }
        
        // 1. 네비게이션바
        navigationController?.navigationBar.barTintColor = DefaultDesign.basicColor
        navigationController?.navigationBar.tintColor = DefaultDesign.basicColor
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = DefaultDesign.backgroundColor
        
        // 2. 레이블
        speechBubbleContentLabel.numberOfLines = 0
        
        
        // [데이터 적용 - 임시 테스트]
        speechBubleImageView.image = UIImage(named: "bubble")
        speechBubbleContentLabel.text = Quates.lifeQuates[Int.random(in: 0..<Quates.lifeQuates.count)]
        speechBubbleContentLabel.textAlignment = .center
        speechBubbleContentLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        speechBubbleContentLabel.textColor = DefaultDesign.basicColor
        tamagotchiImageView.image = UIImage(named: "2-\(Int.random(in: 1...9))")
        designtNameView(view: tamagotchiNameView, label: tamagotchiNameLabel)
        tamagotchiNameLabel.text = "방실방실 다마고치"
        
        for label in midPointLabels {
            label.text = "·"
            label.textColor = DefaultDesign.basicColor
            label.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMax)
        }
        
        let level = UserDefaults.standard.integer(forKey: "level")
        let riceCount = UserDefaults.standard.integer(forKey: "riceCount")
        let waterCount = UserDefaults.standard.integer(forKey: "waterCount")
        
        levelLabel.text = "LV\(level)"
        riceCountLabel.text = "밥알 \(riceCount)개"
        waterCountLabel.text = "물방울 \(waterCount)개"
        
        levelLabel.textColor = DefaultDesign.basicColor
        riceCountLabel.textColor = DefaultDesign.basicColor
        waterCountLabel.textColor = DefaultDesign.basicColor
        
        levelLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        riceCountLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        waterCountLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        
        
        // 텍스트필드
        riceTextField.placeholder = "밥주세용"
        riceTextField.borderStyle = .none
        riceTextField.textAlignment = .center
        riceTextField.keyboardType = .numberPad
        
        waterTextField.placeholder = "물주세용"
        waterTextField.borderStyle = .none
        waterTextField.textAlignment = .center
        waterTextField.keyboardType = .numberPad
        
        
        // line label
        for label in lineLabelCollection {
            label.text = nil
            label.layer.borderColor = DefaultDesign.basicColor.cgColor
            label.layer.borderWidth = 0.5
        }
        
        // 버튼
        ricebutton.tintColor = DefaultDesign.basicColor
        ricebutton.setImage(UIImage(systemName: DefaultDesign.foodButtonIcon), for: .normal)
        ricebutton.setTitle("밥먹기", for: .normal)
        ricebutton.layer.borderWidth = 1
        ricebutton.layer.borderColor = DefaultDesign.basicColor.cgColor
        ricebutton.layer.cornerRadius = 5

        waterButton.tintColor = DefaultDesign.basicColor
        waterButton.setImage(UIImage(systemName: DefaultDesign.waterButtonIcon), for: .normal)
        waterButton.setTitle("물먹기", for: .normal)
        waterButton.layer.borderWidth = 1
        waterButton.layer.borderColor = DefaultDesign.basicColor.cgColor
        waterButton.layer.cornerRadius = 5
        
        
    }
    
    @objc func openSetting() {
        // 네비게이션 바 열어주기
        let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as! SettingTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func riceButtonClicked(_ sender: UIButton) {

        var riceCount =  UserDefaults.standard.integer(forKey: "riceCount")
        if let inputRice = riceTextField.text {
            if let num = Int(inputRice) {
                if num < 100 { riceCount += num }
                else {
                    view.makeToast("한번에 100개 미만만 입력할 수 있어요.")
                    view.endEditing(true)
                    
                }
                } else {
                    riceCount += 1
            }
        } else { riceCount += 1 }
        
        UserDefaults.standard.set(riceCount, forKey: "riceCount")
        riceCountLabel.text = "밥알 \(riceCount)개"
        speechBubbleContentLabel.text = Quates.lifeQuates[Int.random(in: 0..<Quates.lifeQuates.count)]
        
        
        let waterCount =  UserDefaults.standard.integer(forKey: "waterCount")
        let level = getLevel(riceCount: riceCount, waterCount: waterCount)
        levelLabel.text = "LV\(level)"
        
    }
    
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        
        var waterCount =  UserDefaults.standard.integer(forKey: "waterCount")
        if let inputWater = waterTextField.text {
            if let num = Int(inputWater) {
                if num < 50 { waterCount += num }
                else {
                    view.makeToast("한번에 50개 미만만 입력할 수 있어요.")
                    view.endEditing(true)
                    
                }
            }  else {
                waterCount += 1
            }
        } else { waterCount += 1 }
        
        UserDefaults.standard.set(waterCount, forKey: "waterCount")
        waterCountLabel.text = "물방울 \(waterCount)개"
        speechBubbleContentLabel.text = Quates.lifeQuates[Int.random(in: 0..<Quates.lifeQuates.count)]
        
        let riceCount =  UserDefaults.standard.integer(forKey: "riceCount")
        let level = getLevel(riceCount: riceCount, waterCount: waterCount)
        levelLabel.text = "LV\(level)"
    }
    
    
    @IBAction func textFieldDoneClicked(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
}
