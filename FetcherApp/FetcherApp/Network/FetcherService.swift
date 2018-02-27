//
//  FetcherService.swift
//  FetcherApp
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

typealias GetPageResponseType = (AnyObject?, Error?) -> ()
typealias GetResponseType = (CodeResponse?, Error?) -> ()


protocol FetcherServiceProtocol {
    /**
     Retrieves the contents of the specified URL
     - return value:
     - completion block with CodeResponse or Error
     */
    func getResponse(completion: @escaping GetResponseType)
}

class FetcherService: FetcherServiceProtocol {
    
    public private(set) var client: HTTPClientProtocol!
    public private(set) var rootPageSerialiser: SerialiserProtocol!
    public private(set) var codeResponseSerialiser: SerialiserProtocol!
    public private(set) var baseUrl: String
    
    init(client: HTTPClientProtocol = HTTPClient(),
         rootPageSerialiser: SerialiserProtocol = RootPageSerialiser(),
         codeResponseSerialiser: SerialiserProtocol = CodeResponseSerialiser(),
         baseUrl: String = "http://localhost:8000" ) {
        
        self.client = client
        self.rootPageSerialiser = rootPageSerialiser
        self.codeResponseSerialiser = codeResponseSerialiser
        self.baseUrl = baseUrl
    }
    
    func getResponse(completion: @escaping GetResponseType) {
        do {
            self.getPageResponse(serialiser: self.rootPageSerialiser, url: self.baseUrl, completion: { (response, error) in
                if error != nil {
                    completion(nil, error)
                    return
                }
                guard let uwResponse = response as? RootPageResponse else {
                    completion(nil, FetcherAppError.parsingError(nil))
                    return
                }
                
                self.getPageResponse(serialiser: self.codeResponseSerialiser, url: uwResponse.nextPath, completion: { (result, error) in
                    if error != nil {
                        completion(nil, FetcherAppError.parsingError(error?.localizedDescription))
                        return
                    }
                    guard let uwResult = result as? CodeResponse else {
                        completion(nil, FetcherAppError.parsingError(nil))
                        return
                    }
                    completion(uwResult, nil)
                })
            })
        }
    }
    
    private func getPageResponse(serialiser: SerialiserProtocol, url: String, completion: @escaping GetPageResponseType) {
        
        guard let url = URL(string: url) else {
            completion(nil, FetcherAppError.invalidURL())
            return
        }
        
        self.client.get(url) { (data, error) in
            
            if let error = error {
                completion(nil, FetcherAppError.networkError(error.localizedDescription))
                return
            } else if let data = data {
                do {
                    let rootPageResult = try serialiser.serialise(data) as AnyObject
                    completion(rootPageResult, nil)
                    return
                } catch let error as NSError {
                    completion(nil, FetcherAppError.networkError(error.localizedDescription))
                    return
                }
            } else {
                completion(nil, FetcherAppError.networkError(nil))
                return
            }
        }
    }
}
