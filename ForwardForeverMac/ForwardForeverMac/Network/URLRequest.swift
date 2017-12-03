//
//  URLRequest.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

typealias Parameters = [String:Any]

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
    
    var query:String {
        return self.flatMap { (keyValue) -> String? in
            return "\(keyValue.key)=\(keyValue.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            }.joined(separator: "&")
    }
    
    
}

let kAuthorization = "Authorization"

extension URLRequest {
    
    var isAuthenticating:Bool {
        return self.value(forHTTPHeaderField: kAuthorization)?.contains("Basic") ?? false
    }
    
    init(credentials:AuthCredentials,server:Server) throws {
        try self.init(method:.post, server: server, path: "/login")
        let userPasswordString = "\(credentials.username):\(credentials.password)"
        guard
            let userPasswordData = userPasswordString.data(using: .utf8)
            else {
                throw NetworkError.LoginFailed
        }
        let authString = "Basic \(userPasswordData.base64EncodedString())"
        self.setValue(authString, forHTTPHeaderField: kAuthorization)
    }
    
    init<T>(server:Server,path:String,requestModel:T) throws where T:Codable {
        let jsonData = try JSONEncoder().encode(requestModel)
        
        try self.init(method: .post, scheme: server.scheme, host: server.host, port: server.port, path: path, query: nil, body: jsonData)
    }
    
    init(server:Server,path:String,query:Parameters) throws {
        try self.init(method: .get, scheme: server.scheme, host: server.host, port: server.port, path: path, query: query.query, body: nil)
    }
    
    init(method:HTTPMethod,server:Server,path:String) throws {
        try self.init(method: method, scheme: server.scheme, host: server.host, port: server.port, path: path, query: nil, body: nil)
    }
    
    init(method:HTTPMethod,scheme:HTTPScheme,host:String,port:Int,path:String,query:String?,body:Data?) throws {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.description
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.port = port
        urlComponents.query = query
        
        guard let url = urlComponents.url else {
            throw NetworkError.URLCreationFailed
        }
        
        self.init(url: url)
        
        self.httpMethod = method.description
        self.httpBody = body
    }
    
    func tokenized(withToken token:String) -> URLRequest {
        var modifiedRequest = self
        modifiedRequest.setValue("Bearer \(token)", forHTTPHeaderField: kAuthorization)
        return modifiedRequest
    }
    
    
}
