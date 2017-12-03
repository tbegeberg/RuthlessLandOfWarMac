//
//  NetworkCompleter.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

struct NetworkCompleter<T> where T:Decodable {
    let responseProvider:( () throws -> (T) ) -> ()
    
    func success(_ value:T) {
        DispatchQueue.main.async {
            self.responseProvider { () -> (T) in
                return value
            }
        }
    }
    
    func error(_ error:Error) {
        DispatchQueue.main.async {
            self.responseProvider { () -> (T) in
                throw error
            }
        }
    }
    
    func complete(_ block:() throws -> (T?)) {
        
        do {
            guard let value = try block() else {
                return
            }
            self.success(value)
        } catch let error {
            self.error(error)
        }
        
    }
}
