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
    
    // 저장 속성
    let tamagotchiDic = TamagotchiInfo().tamagotchiDic
    
    // 아울렛 변수
    @IBOutlet weak var speechBubleImageView: UIImageView!
    @IBOutlet weak var speechBubbleContentLabel: UILabel!
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    
    @IBOutlet var midPointLabels: [UILabel]!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var riceCountLabel: UILabel!
    @IBOutlet weak var waterCountLabel: UILabel!
        
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
        
    @IBOutlet weak var ricebutton: UIButton!
    @IBOutlet weak var waterButton: UIButton!
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet var lineLabelCollection: [UILabel]!
    @IBOutlet var clearBackgroundViewCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designUI()
    }
    
    // 뷰가 보여질때마다 닉네임과 다마고치 이야기 새로고침
    override func viewWillAppear(_ animated: Bool) {
        let nickname = UserDefaults.standard.string(forKey: SaveKey.nickname)
        
        setSpeechBubble()
        navigationItem.title = "\(nickname ?? "대장")님의 다마고치"
    }
    
    // MARK: - [함수]
    func setSpeechBubble() {
        guard let tamagotchi = UserDefaults.standard.string(forKey: SaveKey.tamagotchi) else {
            print("Nil userDefault \(SaveKey.tamagotchi)")
            speechBubbleContentLabel.text = nil
            return
        }
        if var idx = tamagotchiDic[tamagotchi] {
            idx -= 1
            let text = Quates.quates[idx][Int.random(in: 0..<Quates.quates[idx].count)]
            speechBubbleContentLabel.designPrintInfoLabel(text: text)
        }
    }
                                                      
    // MARK: - [디자인]
    func designUI() {
        designBackground()
        designNavigationBar()
        designSpeechBubble()
        designTamagotchi()
        designLine()
        designMidPointLabel()
        designLabel()
        designTextField()
        designButton()
    }
    
    func designBackground() {
        view.backgroundColor = DefaultDesign.backgroundColor
        for view in clearBackgroundViewCollection {
            view.clearBackground()
        }
    }
    func designNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: DefaultDesign.basicColor]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: DefaultDesign.oepnSettingButtonIcon), style: .plain, target: self, action: #selector(openSetting))
        
        navigationController?.navigationBar.barTintColor = DefaultDesign.basicColor
        navigationController?.navigationBar.tintColor = DefaultDesign.basicColor
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = DefaultDesign.backgroundColor
        
    }
    func designSpeechBubble() {
        speechBubleImageView.image = UIImage(named: "bubble")
        setSpeechBubble()
        speechBubbleContentLabel.numberOfLines = 0
    }
    func designTamagotchi() {
        let tamagotchiName = UserDefaults.standard.string(forKey: SaveKey.tamagotchi)
        let riceCount = UserDefaults.standard.integer(forKey: SaveKey.riceCount)
        let waterCount = UserDefaults.standard.integer(forKey: SaveKey.waterCount)
        var level = getLevel(riceCount: riceCount, waterCount: waterCount)
        level = (level >= 10) ? 9 : level
        
        tamagotchiNameLabel.text = UserDefaults.standard.string(forKey: SaveKey.tamagotchi)
        designtNameView(view: tamagotchiNameView, label: tamagotchiNameLabel)
        
        if let name = tamagotchiName {
            tamagotchiImageView.image = UIImage(named: "\(tamagotchiDic[name]!)-\(level)")
        } else {
            tamagotchiImageView.image = UIImage(named: "1-\(level)")
        }
    }
    func designLine() {
        for label in lineLabelCollection {
            label.designLine()
        }
    }
    func designMidPointLabel() {
        for label in midPointLabels {
            label.designPrintInfoLabel(text: "·")
        }
    }
    func designLabel() {
        let riceCount = UserDefaults.standard.integer(forKey: SaveKey.riceCount)
        let waterCount = UserDefaults.standard.integer(forKey: SaveKey.waterCount)
        
        levelLabel.designPrintInfoLabel(text: "LV\(getLevel(riceCount: riceCount, waterCount: waterCount))")
        riceCountLabel.designPrintInfoLabel(text: "밥알 \(riceCount)개")
        waterCountLabel.designPrintInfoLabel(text: "물방울 \(waterCount)개")
    }
    func designTextField() {
        riceTextField.designTextField(placeholder: "밥주세용")
        waterTextField.designTextField(placeholder: "물주세용")
    }
    func designButton() {
        ricebutton.designEatButton(title: "밥먹기", imageName: DefaultDesign.foodButtonIcon)
        waterButton.designEatButton(title: "물먹기", imageName: DefaultDesign.waterButtonIcon)
    }
                                                         
                                                
    // MARK: - [클릭액션]
    @objc func openSetting() {
        // 네비게이션 바 열어주기
        let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as! SettingTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func riceButtonClicked(_ sender: UIButton) {
        var riceCount = UserDefaults.standard.integer(forKey: SaveKey.riceCount)
        riceCount += getIntByTextFieldText(limit: 100, textField: riceTextField)
        UserDefaults.standard.set(riceCount, forKey: SaveKey.riceCount)
        
        designLabel()
        designTamagotchi()
        setSpeechBubble()
        view.endEditing(true)
        
    }
    @IBAction func waterButtonClicked(_ sender: UIButton) {
        var waterCount = UserDefaults.standard.integer(forKey: SaveKey.waterCount)
        waterCount += getIntByTextFieldText(limit: 50, textField: waterTextField)
        UserDefaults.standard.set(waterCount, forKey: SaveKey.waterCount)
        
        designLabel()
        designTamagotchi()
        setSpeechBubble()
        view.endEditing(true)
    }
    
    func getIntByTextFieldText(limit: Int, textField: UITextField) -> Int {
        guard let text = textField.text, !text.isEmpty else { return 1 }
        guard let num = Int(text) else {
            view.makeToast("숫자만 입력할 수 있습니다.")
            textField.text = nil
            view.endEditing(true)
            return 0
        }
        if num > limit {
            view.makeToast("한번에 \(limit) 미만만 입력이 가능합니다.")
            textField.text = String(limit - 1)
            view.endEditing(true)
            return 0
        } else {
            return num
        }
    }
}
