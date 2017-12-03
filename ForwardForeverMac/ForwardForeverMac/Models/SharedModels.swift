//
//  SharedModels.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

func getRandomNum(_ min: Int, _ max: Int) -> Int {
    #if os(Linux)
        return Int(random() % max) + min
    #else
        return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
    #endif
}


class SharedModels {
    
    struct Ok:Codable {
        let ok:Bool
    }
    
}
