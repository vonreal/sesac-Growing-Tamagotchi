//
//  SettingTableViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/24.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    static let identifier = "SettingTableViewController"

    let settingList = ["내 이름 설정하기", "다마고치 변경하기", "데이터 초기화"]
    let settingImage = ["pencil", "moon.fill", "arrow.clockwise"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultDesign.backgroundColor
        navigationItem.title = "설정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backbutton))
        
    }
    
    @objc func backbutton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        cell.titleLabel.text = settingList[indexPath.row]
        cell.detailLabel.text = nil
        cell.detailLabel.textColor = DefaultDesign.basicColor
        cell.detailLabel.font = .systemFont(ofSize: DefaultDesign.fontSizeMin)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: settingImage[indexPath.row])
        cell.titleLabel.font = .boldSystemFont(ofSize: DefaultDesign.fontSizeMin)
        cell.imageView?.tintColor = DefaultDesign.basicColor
        cell.backgroundColor = .clear
        
        if indexPath.row == 0 {
            cell.detailLabel.text = UserDefaults.standard.string(forKey: SaveKey.nickname)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: NameSettingViewController.identifier) as! NameSettingViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SelectTamagotchiCollectionViewController") as! SelectTamagotchiCollectionViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 처음부터 시작하시겠습니까?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "예", style: .default) { yes in
                             
                UserDefaults.standard.set(false, forKey: SaveKey.save)
                
                // 초기화코드
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let storyBoard = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
                let viewCon = storyBoard.instantiateViewController(withIdentifier: "SelectTamagotchiCollectionViewController") as! SelectTamagotchiCollectionViewController
                
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewCon)
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            let no = UIAlertAction(title: "아니", style: .cancel)
            
            
            alert.addAction(no)
            alert.addAction(yes)
            
            self.present(alert, animated: true)
        default:
            return
        }
    }
}
