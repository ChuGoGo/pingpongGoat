//
//  PlayerGame.swift
//  pingpongGoat
//
//  Created by Chu Go-Go on 2022/1/13.
//

import Foundation
struct Player {
//    比分
    var pointNum: Int = 0
//    贏分的場數
    var WinCount: Int = 0
//    duce時的比分
    var ducePoint: Int = 0
//     判斷發球方
    var serve : Bool
    init(serve : Bool) {
        self.serve = serve
    }

}
