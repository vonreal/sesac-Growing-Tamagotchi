//
//  SelectTamagotchiCollectionViewController.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import UIKit
import Toast

class SelectTamagotchiCollectionViewController: UICollectionViewController {

    let tamagotchInfos = TamagotchiInfo().tamagotchiList
    let defaultTamagotch = TamagotchiInfo().defaultTamagotchi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designCollectionView()
    }
    
    // MARK: - 아이템 갯수
    // [요구사항] 최소 20개 이상
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    // MARK: - 아이템의 데이터
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectTamagotchiCollectionViewCell.identifier, for: indexPath) as? SelectTamagotchiCollectionViewCell else { print("Not found SelectTamagotchiCollectionViewCell"); return UICollectionViewCell()}
        
        if indexPath.row < tamagotchInfos.count {
            let idx = tamagotchInfos[indexPath.row]
            cell.tamagotchiImageView.image = UIImage(named: idx.image)
            cell.tamagotchiNameLabel.text = idx.name
        } else {
            cell.tamagotchiImageView.image = UIImage(named: defaultTamagotch.image)
            cell.tamagotchiNameLabel.text = defaultTamagotch.name
        }
        designtNameView(view: cell.tamagotchiNameView, label: cell.tamagotchiNameLabel)
        
        return cell
    }
    
    // MARK: - [디자인] 셀 크기, 사이 간격 등의 디자인 요소 설정
    func designCollectionView() {
        navigationItem.title = "다마고치 선택하기"
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 11
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing * 2, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing * 2
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundView?.backgroundColor = DefaultDesign.backgroundColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "SelectTamagotchi", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: AlertViewController.identifier) as? AlertViewController else { print("Not found AlertViewController"); return }
        
        if indexPath.row < tamagotchInfos.count {
            let tamagotchInfo = tamagotchInfos[indexPath.row]
            vc.tamagotchiImage = tamagotchInfo.image
            vc.tamagotchiName = tamagotchInfo.name
            vc.tamagotchiInfo = tamagotchInfo.info
            
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
            
        } else {
            self.view.hideAllToasts()
            self.view.makeToast("준비중입니다.")
        }
    }
}
