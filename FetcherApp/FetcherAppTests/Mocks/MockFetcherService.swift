//
//  MockFetcherService.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation
@testable import FetcherApp

class MockFetcherService: FetcherServiceProtocol {
    var getResponseCalled: Int = 0
    var returnResponseCode: UUID = UUID()
    var error: Error?
    
    func getResponse(completion: @escaping GetResponseType) {
        getResponseCalled = getResponseCalled + 1
        let response = CodeResponse(path: "http://localhost", responseCode: self.returnResponseCode)
        completion (response, self.error)
    }
    
}
