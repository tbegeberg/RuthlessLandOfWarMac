//
//  BoardNode.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

struct BoardNode:Equatable,Codable {
    static func ==(lhs: BoardNode, rhs: BoardNode) -> Bool {
        return lhs.position == rhs.position
    }
    
    let uuid:String
    let position:Position
    let random:Int
    
    init(position:Position) {
        self.position = position
        self.uuid = UUID().uuidString
        self.random = getRandomNum(0, 10)
    }
    
}
