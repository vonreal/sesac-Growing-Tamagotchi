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
        
        navigationItem.title = "설정"
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        cell.titleLabel.text = settingList[indexPath.row]
        cell.detailLabel.text = nil
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(systemName: settingImage[indexPath.row])
        cell.imageView?.tintColor = DefaultDesign.basicColor
        
        return cell
    }
}
