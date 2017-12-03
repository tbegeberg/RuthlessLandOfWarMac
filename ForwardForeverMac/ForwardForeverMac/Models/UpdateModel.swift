//
//  UpdateModel.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

class UpdateModel {
    struct Request:CodableEndpoint {
        typealias ResponseType = Response
        static var endPoint: String = "update"
    }
    
    struct Response:Codable {
        let relativeNodes:[RelativeBoardNode]
    }
}

