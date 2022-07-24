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
        
        view.backgroundColor = DefaultDesign.backgroundColor
        
        let nickname = UserDefaults.standard.string(forKey: SaveKey.nickname)
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveName))
        
        userinputTextField.placeholder = "이름을 입력해주세요"
        userinputTextField.text = nickname ?? nil
        userinputTextField.borderStyle = .none
        userinputTextField.textColor = DefaultDesign.basicColor
        
        lineLabel.layer.borderWidth = 0.5
        lineLabel.layer.borderColor = DefaultDesign.basicColor.cgColor
    }
    
    @objc func saveName() {
        if userinputTextField.text!.count < 2 || userinputTextField.text!.count > 6 {
            view.makeToast("2글자 이상 6글자 이하까지 가능합니다.")
            return
        }
        if userinputTextField.text != nil {
            UserDefaults.standard.set(userinputTextField.text, forKey: SaveKey.nickname)
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
