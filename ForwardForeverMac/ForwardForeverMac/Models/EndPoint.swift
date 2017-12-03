//
//  EndPoint.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

protocol EndPoint {
    
    associatedtype ResponseType:Codable
    
    static var endPoint:String { get }
    
}

protocol CodableEndpoint:Codable,EndPoint {}

extension CodableEndpoint {
    
    func run(completion: @escaping ( () throws -> (Self.ResponseType) ) -> ()) {
        Network.shared.run(requestModel: self, completion: completion)
    }
    
}
