//
//  Network.swift
//  ForwardForeverMac
//
//  Created by TørK on 03/12/2017.
//  Copyright © 2017 Tørk Egeberg. All rights reserved.
//

import Foundation

class Network {
    
    static let shared = Network(server: Server(host: "ruthless.theisegeberg.com", scheme: HTTPScheme.https, port:nil))
    
    let session:URLSession
    
    var bearerToken:String?
    var server:Server
    
    init(server:Server) {
        self.server = server
        self.session = URLSession.shared
    }
    
    func authenticate(credentials:AuthCredentials, completion:NetworkCompleter<TokenModel.Response>) {
        
        completion.complete { () -> (TokenModel.Response?) in
            
            self.bearerToken = nil
            
            let loginRequest = try URLRequest(credentials: credentials, server:self.server)
            
            self.run(request: loginRequest, completion: NetworkCompleter<TokenModel.Response> { (responseProvider) in
                do {
                    let tokenResponse = try responseProvider()
                    self.bearerToken = tokenResponse.token
                    completion.success(tokenResponse)
                } catch let error {
                    completion.error(error)
                }
            })
            return nil
            
        }
        
    }
    
    func run<J>(requestModel:J,completion: @escaping ( () throws -> (J.ResponseType) ) -> () ) where J:CodableEndpoint {
        
        let networkCompleter = NetworkCompleter<J.ResponseType>(responseProvider: completion)
        
        networkCompleter.complete { () -> (J.ResponseType?) in
            
            let request = try URLRequest(server: self.server, path: "/\(J.endPoint)", requestModel: requestModel)
            
            self.run(request: request, completion: networkCompleter)
            
            return nil
        }
        
    }
    
    func run<T>(request:URLRequest,completion:NetworkCompleter<T>) {
        
        let requestMaker = {
            () -> (URLRequest) in
            guard let token = self.bearerToken else {
                return request
            }
            return request.tokenized(withToken: token)
            
        }
        
        let request = requestMaker()
        
        let task = self.session.dataTask(with: request) { (data, response, error) in
            
            completion.complete({ () -> (T?) in
                
                if let error = error {
                    let nsError = error as NSError
                    switch nsError.code {
                    case -1004:
                        guard let url = request.url else {
                            break
                        }
                        throw NetworkError.UnableToConnectToServer(url)
                    default:
                        throw error
                    }
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.MalformedResponse
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    break
                    
                case 401:
                    
                    self.bearerToken = nil
                    throw NetworkError.Unauthorised(request)
                    
                default:
                    
                    if
                        let data = data,
                        let vaporError = try? JSONDecoder().decode(VaporError.self, from: data)
                    {
                        throw NetworkError.VaporError(httpResponse.statusCode, vaporError)
                    }
                    
                    
                    throw NetworkError.HTTPError(httpResponse.statusCode)
                }
                
                if let data = data {
                    return try JSONDecoder().decode(T.self, from: data)
                }
                
                return nil
                
            })
            
        }
        task.resume()
    }
    
}
