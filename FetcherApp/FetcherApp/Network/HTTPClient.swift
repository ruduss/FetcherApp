//
//  HTTPClient.swift
//  FetcherApp
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

typealias HTTPResult = (Data?, Error?) -> Void

protocol HTTPClientProtocol {
    /**
     Retrieves the contents of the specified URL
     - parameters:
     - url: The URL to be retrieved.
     - return value:
     - completion block with HTTPResult
     */
    func get(_ url: URL, completion: @escaping HTTPResult)
}

class HTTPClient: HTTPClientProtocol {
    
    fileprivate let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(_ url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = session.dataTaskWithUrl(url) { (data, response, error) -> Void in
            if let error = error {
                completion(nil, FetcherAppError.networkError(error.localizedDescription))
            } else if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                completion(data, nil)
            } else {
                completion(nil, FetcherAppError.networkError(nil))
            }
        }
        task.resume()
    }
}
