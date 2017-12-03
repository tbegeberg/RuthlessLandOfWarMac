//
//  UserRegisterPoint.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

class UserRegister {
    
    struct Request:CodableEndpoint {
        
        typealias ResponseType = Response
        
        static var endPoint: String = "user/register"
        
        let name:String
        let email:String
        let password:String
        
    }
    
    struct Response:Codable {
        let userId:Int
    }
    
}
