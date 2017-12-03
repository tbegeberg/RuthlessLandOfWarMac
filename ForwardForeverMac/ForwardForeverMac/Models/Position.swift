//
//  Position.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

typealias Vector = Position

struct Position:Codable,Equatable {
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func +(lhs:Position,rhs:Position)->Position {
        return Position(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
    }
    
    static func -(lhs:Position,rhs:Position)->Position {
        return Position(x: lhs.x-rhs.x, y: lhs.y-rhs.y)
    }
    
    static func *(lhs:Position,rhs:Position)->Position {
        return Position(x: lhs.x*rhs.x, y: lhs.y*rhs.y)
    }
    
    let x:Int
    let y:Int
}

