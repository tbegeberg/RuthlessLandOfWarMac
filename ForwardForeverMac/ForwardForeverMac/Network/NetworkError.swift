//
//  NetworkError.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

struct VaporError:Decodable {
    let identifier:String
    let reason:String
    let debugReason:String
    let error:Bool
}

enum NetworkError:Error {
    case URLCreationFailed
    case MalformedResponse
    case HTTPError(Int)
    case VaporError(Int,VaporError)
    case LoginFailed
    case Unauthorised(URLRequest)
    case UnableToConnectToServer(URL)
}
