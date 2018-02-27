//
//  MockTask.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let responseError: Error?
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = error
    }
    
    override func resume() {
        DispatchQueue.main.async() {
            self.completionHandler?(self.data, self.urlResponse, self.responseError)
        }
    }
    
}
