//
//  SettingTableViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"

    // 저장속성
    let settingList = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    let settingImage = ["pencil", "moon.fill", "arrow.clockwise"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
    }
    
    // 바뀐 데이터 적용
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    // MARK: [디자인]
    func designUI() {
        view.backgroundColor = DefaultDesign.backgroundColor
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backbutton))
    }
    
    // MARK: - 아이템 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - 행의 데이터 및 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { print("Not found \(SettingTableViewCell.identifier)"); return UITableViewCell() }
        
        cell.titleLabel.text = settingList[indexPath.row]
        cell.titleLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        
        cell.accessoryType = .disclosureIndicator
        
        cell.imageView?.image = UIImage(systemName: settingImage[indexPath.row])
        cell.imageView?.tintColor = DefaultDesign.basicColor
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cell.backgroundColor = .clear
        
        if indexPath.row == 0 {
            cell.detailLabel.text = UserDefaults.standard.string(forKey: SaveKey.nickname) ?? "대장"
        } else {
            cell.detailLabel.designPrintInfoLabel(text: "")
        }
        
        return cell
    }
    
    // MARK: - [클릭액션]
    
    // 뒤로가기 클릭 시
    @objc func backbutton() {
        self.navigationController?.popViewController(animated: true)
    }
    // 행을 클릭했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: NameSettingViewController.identifier) as? NameSettingViewController else { print("Not found \(NameSettingViewController.identifier)"); return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiCollectionViewController.identifier) as? SelectTamagotchiCollectionViewController else { print("Not found \(SelectTamagotchiCollectionViewController.identifier)"); return}
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 처음부터 다시 시작하시겠습니까?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "예", style: .destructive) { yes in
                UserDefaults.standard.set(false, forKey: SaveKey.save)
                
                // 유저디폴트 일괄 초기화
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiCollectionViewController.identifier) as? SelectTamagotchiCollectionViewController else { print("Not found \(SelectTamagotchiCollectionViewController.identifier)"); return}
                
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            let no = UIAlertAction(title: "아니오", style: .default)
                        
            alert.addAction(no)
            alert.addAction(yes)
            
            self.present(alert, animated: true)
            
        default:
            return
        }
    }
}
