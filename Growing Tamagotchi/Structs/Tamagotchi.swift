//
//  Tamagotchi.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/25.
//

import Foundation
import UIKit

struct Tamagotchi {
    var image: String
    var name: String
    var info: String
}

struct TamagotchiInfo {
    let tamagotchiDic: [String:Int] = ["따끔따끔 다마고치":1, "방실방실 다마고치":2, "반짝반짝 다마고치":3]
    var tamagotchiList = [Tamagotchi(image: "1-6", name: "따끔따끔 다마고치", info: "안녕하세요. 저는 따끔따끔 다마고치입니다.\n 저는 디즈니를 좋아해요.\n 디즈니에서 나온 좋은 말을 알려드릴게요. "),
                          Tamagotchi(image: "2-6", name: "방실방실 다마고치", info: "나는야 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용\n 성격은 화끈하고 날라다닙니당~!\n 열심히 잘 먹고 잘 클 자신은 있땁니당 방실방실!"),
                          Tamagotchi(image: "3-6", name: "반짝반짝 다마고치", info: "와타시와 키라키라 다마고치데스!\n 저는 일본에서 온 다마고치입니다.\n 일본 애니메이션의 명대사를 알려드릴게요~")]
    var defaultTamagotchi = Tamagotchi(image: "noImage", name: "준비중이에요", info: "준비중입니다.")
}

func getLevel(riceCount: Int, waterCount: Int) -> Int {
    let total = Int((riceCount / 5) + (waterCount / 2))
    let level = total / 10
    
    if level == 0 { return 1 }
    if level >= 10 { return 10 }
    return level
}

struct SaveKey {
    static let nickname = "nickname"
    static let tamagotchi = "tamagotchi"
    static let save = "save"
    static let level = "level"
    static let riceCount = "riceCount"
    static let waterCount = "waterCount"
}
