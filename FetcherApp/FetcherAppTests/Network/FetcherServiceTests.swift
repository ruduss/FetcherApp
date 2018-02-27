//
//  FetcherServiceTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class FetcherServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testGetResponse_WithValidParameters_ShouldReturnResponse() {
        // GIVEN
        let mockData: Data = JsonHelpers.getJsonFile("response")!
        let client = MockHTTPClient()
        client.data = mockData
        
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockCodeResponseSerialiser()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(results)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
        
    }
    
    func testSerialise_WithInValidURL_ShouldError() {
        // GIVEN
        let mockData: Data = JsonHelpers.getJsonFile("response")!
        let client = MockHTTPClient()
        client.data = mockData
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockCodeResponseSerialiser()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser,
                                            baseUrl: "<<<<<>>>>>>>>>")
        
        let expectation = self.expectation(description: "")
        let expectedError = FetcherAppError.invalidURL()
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            if let error = error {
                XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
            }
            XCTAssertNil(results)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    func testSerialise_WithErrorResponse_ShouldError() {
        // GIVEN
        let expectedError = FetcherAppError.networkError("The operation couldn’t be completed. (FetcherApp.FetcherAppError error 0.)")
        let client = MockHTTPClient()
        client.error = expectedError
        
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockCodeResponseSerialiser()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    func testSerialise_WithInvalidRootPageResponse_ShouldError() {
        // GIVEN
        let mockData: Data = JsonHelpers.getJsonFile("responseInvalidJson")!
        let client = MockHTTPClient()
        client.data = mockData
        let rootPageSerialiser = MockSerialiserReturnsNil()
        let codeResponseSerialiser = MockCodeResponseSerialiser()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        let expectedError = FetcherAppError.parsingError(nil)
        
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    func testSerialise_WithInvalidCodeResponse_ShouldError() {
        // GIVEN
        let mockData: Data = JsonHelpers.getJsonFile("responseInvalidJson")!
        let client = MockHTTPClient()
        client.data = mockData
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockSerialiserReturnsNil()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        let expectedError = FetcherAppError.parsingError(nil)
        
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    func testSerialise_WithCodeResponseError_ShouldError() {
        // GIVEN
        let mockData: Data = JsonHelpers.getJsonFile("responseInvalidJson")!
        let client = MockHTTPClient()
        client.data = mockData
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockSerialiserThrowsError()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        let expectedError = FetcherAppError.parsingError("The operation couldn’t be completed. (FetcherApp.FetcherAppError error 1.)")
        
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
    func testSerialise_WithNoResponseFromHTTPClient_ShouldError() {
        // GIVEN
        let client = MockHTTPClientNilResponses()
        let rootPageSerialiser = MockRootPageSerialiser()
        let codeResponseSerialiser = MockSerialiserThrowsError()
        let fetcherService = FetcherService(client: client,
                                            rootPageSerialiser: rootPageSerialiser,
                                            codeResponseSerialiser: codeResponseSerialiser)
        let expectedError = FetcherAppError.networkError(nil)
        
        let expectation = self.expectation(description: "")
        
        // WHEN
        fetcherService.getResponse{ (results, error) in
            XCTAssertNil(results)
            XCTAssertNotNil(error)
            XCTAssertEqual(error?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("timeout errored: \(error)")
            }
        }
    }
    
}
