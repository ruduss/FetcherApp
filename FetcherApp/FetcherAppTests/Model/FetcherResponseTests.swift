//
//  CodeResponseTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class CodeResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testInit_WithValidParameters_ShouldInitialise() {
        // GIVEN
        let expectedPath = "d"
        let expectedResponse = UUID()
        
        // WHEN
        let result = CodeResponse(path: expectedPath, responseCode: expectedResponse)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.path, expectedPath)
        XCTAssertEqual(result.responseCode, expectedResponse)
    }
    
}
