//
//  MockURLSession.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation
@testable import FetcherApp

class MockURLSession: URLSessionProtocol {
    
    var url: URL?
    private let dataTask: MockTask
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
        self.data = data
        self.response = urlResponse
        self.error = error
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        dataTask.completionHandler = completionHandler
        return dataTask
    }
    
    func dataTaskWithUrl(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(self.data, self.response, self.error)
        return MockURLSessionDataTask()
    }
    
}
