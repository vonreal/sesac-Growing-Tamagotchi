//
//  NameSettingViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/24.
//

import UIKit
import Toast

class NameSettingViewController: UIViewController {
    
    static let identifier = "NameSettingViewController"

    @IBOutlet weak var userinputTextField: UITextField!
    @IBOutlet weak var lineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
    }
    
    // MARK: - [디자인]
    func designUI() {
        view.backgroundColor = DefaultDesign.backgroundColor
        
        designNavigationBar()
        designTextField()
        lineLabel.designLine()
    }
    
    func designNavigationBar() {
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveName))
    }
    func designTextField() {
        let nickname = UserDefaults.standard.string(forKey: SaveKey.nickname)
        userinputTextField.placeholder = "대장님의 이름을 입력해주세요."
        userinputTextField.borderStyle = .none
        userinputTextField.text = nickname ?? "대장"
    }
    
    // MARK: - [클릭시]
    @objc func saveName() {
        guard let nickname = userinputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                (2...6).contains(nickname.count)
        else {
            view.makeToast("2글자 이상 6글자 이하까지 가능합니다.")
            view.endEditing(true)
            return
        }
        UserDefaults.standard.set(nickname, forKey: SaveKey.nickname)
        self.navigationController?.popViewController(animated: true)
    }
}
