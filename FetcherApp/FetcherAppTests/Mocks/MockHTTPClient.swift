//
//  File.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit
@testable import FetcherApp

class MockHTTPClient: HTTPClientProtocol {
    var data: Data?
    var error: Error?
    
    func get(_ url: URL, completion: @escaping HTTPResult) {
        completion(self.data, self.error)
    }
    
}

class MockHTTPClientNilResponses: HTTPClientProtocol {
    var data: Data?
    var error: Error?
    
    func get(_ url: URL, completion: @escaping HTTPResult) {
        completion(nil, nil)
    }
    
}
