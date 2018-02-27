//
//  RootPageResponseTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 22/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class RootPageResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testInit_WithValidParameters_ShouldInitialise() {
        // GIVEN
        let expectedNextPath = "d"
        
        // WHEN
        let result = RootPageResponse(nextPath: expectedNextPath)
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result.nextPath, expectedNextPath)
    }
    
}
