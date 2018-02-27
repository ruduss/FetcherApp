//
//  MockURLSessionDataTask.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation
@testable import FetcherApp

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    fileprivate (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
