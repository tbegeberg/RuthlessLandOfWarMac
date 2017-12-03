//
//  MoveModel.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

class MoveModel {
    
    struct Request:CodableEndpoint {
        typealias ResponseType = SharedModels.Ok
        static var endPoint: String = "moveOrder"
        let moveBy:Vector
        
    }
    
}
