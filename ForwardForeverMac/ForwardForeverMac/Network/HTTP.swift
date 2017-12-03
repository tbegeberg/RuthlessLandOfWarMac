//
//  HTTP.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

enum HTTPScheme:CustomStringConvertible {
    case http,https
    
    var description: String {
        switch self {
        case .http:
            return "http"
        case .https:
            return "https"
        }
    }
    
    var defaultPort:Port {
        switch self {
        case .http:
            return 80
        case .https:
            return 443
        }
    }
}

enum HTTPMethod:CustomStringConvertible {
    case get
    case post
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
    
}


