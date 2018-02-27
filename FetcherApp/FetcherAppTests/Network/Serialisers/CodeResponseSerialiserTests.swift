//
//  FetcherParserTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class CodeResponseSerialiserTests: XCTestCase {
    
    var codeResponseSerialiser: CodeResponseSerialiser!
    
    override func setUp() {
        super.setUp()
        self.codeResponseSerialiser = CodeResponseSerialiser()
    }
    
    func testSerialise_WithValidParameters_ShouldSerialise() {
        // GIVEN
        let expectedResult = CodeResponse(path: "d", responseCode: UUID(uuidString: "8f26843d-581d-40cb-9e81-aeccd9727902")!)
        let data: Data = JsonHelpers.getJsonFile("response")!
        var result: CodeResponse?
        
        // WHEN
        do {
            try result = self.codeResponseSerialiser.serialise(data) as? CodeResponse
        
            // THEN
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.path, expectedResult.path)
            XCTAssertEqual(result?.responseCode, expectedResult.responseCode)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidKeys_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseErrorReturned")!
        var result: CodeResponse?
        let expectedError: Error = FetcherAppError.parsingError(nil)
        
        // WHEN
        do {
            try result = self.codeResponseSerialiser.serialise(data) as? CodeResponse
        } catch let error {
            // THEN
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidJson_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseInvalidJson")!
        var result: CodeResponse?
        let expectedError: Error = FetcherAppError.serialisationError(nil)
        
        // WHEN
        do {
            try result = self.codeResponseSerialiser.serialise(data) as? CodeResponse
        } catch let error {
            // THEN
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
    func testSerialise_WithInValidUUID_ShouldThrowError() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("responseInvalidUUID")!
        var result: CodeResponse?
        let expectedError: Error = FetcherAppError.parsingError("invalid UUID")
        
        // WHEN
        do {
            try result = self.codeResponseSerialiser.serialise(data) as? CodeResponse
        } catch let error {
            // THEN
            XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
        }
    }
    
}
