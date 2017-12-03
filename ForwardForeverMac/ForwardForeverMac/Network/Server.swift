//
//  File.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

typealias Port = Int
typealias Host = String

struct Server {
    let host:Host
    let port:Port
    let scheme:HTTPScheme
    
    init(host:Host,scheme:HTTPScheme,port:Port?) {
        self.host = host
        self.port = {
            guard let port = port else {
                return scheme.defaultPort
            }
            return port
        }()
        self.scheme = scheme
    }
}
