//
//  Tamagotchi.swift
//  Growing Tamagotchi
//
//  Created by 나지운 on 2022/07/22.
//

import Foundation
import UIKit

struct Tamagotchi {
    var image: String
    var name: String
    var info: String
}

struct TamagotchiInfo {
    var tamagotchiList = [Tamagotchi(image: "1-6", name: "따끔따끔 다마고치", info: "나는야 따끔따끔한 다마고치당"),
                          Tamagotchi(image: "2-6", name: "방실방실 다마고치", info: "나는야 방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용\n 성격은 화끈하고 날라다닙니당~!\n 열심히 잘 먹고 잘 클 자신은 있땁니당 방실방실!"),
                          Tamagotchi(image: "3-6", name: "반짝반짝 다마고치", info: "와타시와 키라키라 다마고치데스!")]
    
    var defaultTamagotchi = Tamagotchi(image: "noImage", name: "준비중이에요", info: "준비중입니다.")
}
