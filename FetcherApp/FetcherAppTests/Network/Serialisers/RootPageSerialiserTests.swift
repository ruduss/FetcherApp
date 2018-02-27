//
//  RootPageSerialiserTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class RootPageSerialiserTests: XCTestCase {
    
    var rootPageSerialiser: RootPageSerialiser!
    
    override func setUp() {
        super.setUp()
        self.rootPageSerialiser = RootPageSerialiser()
    }
    
    func testSerialise_WithValidParameters_ShouldSerialise() {
        // GIVEN
        let expectedResult = RootPageResponse(nextPath: "http://localhost:8000/d/")
        let data: Data = JsonHelpers.getJsonFile("rootPageResponse")!
        var result: RootPageResponse?
        
        // WHEN
        do {
            try result = self.rootPageSerialiser.serialise(data) as? RootPageResponse
            
            // THEN
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.nextPath, expectedResult.nextPath)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidKeys_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseErrorReturned")!
        var result: RootPageResponse?
        let expectedError: Error = FetcherAppError.parsingError(nil)
        
        // WHEN
        do {
            try result = self.rootPageSerialiser.serialise(data) as? RootPageResponse
        } catch let error {
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidJson_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseInvalidJson")!
        var result: RootPageResponse?
        let expectedError: Error = FetcherAppError.serialisationError(nil)
        
        // WHEN
        do {
            try result = self.rootPageSerialiser.serialise(data) as? RootPageResponse
        } catch let error {
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidUUID_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseInvalidUUID")!
        var result: RootPageResponse?
        let expectedError: Error = FetcherAppError.parsingError("invalid UUID")
        
        // WHEN
        do {
            try result = self.rootPageSerialiser.serialise(data) as? RootPageResponse
        } catch let error {
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
}
