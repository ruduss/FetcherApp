//
//  HTTPClientTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class HTTPClientTests: XCTestCase {
   
    override func setUp() {
        super.setUp()
    }
    
    func testGet_WithValidParms_RequestsTheURL() {
        // GIVEN
        let data: Data = JsonHelpers.getJsonFile("response")!
        let urlResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!, statusCode: 200,
                                          httpVersion: nil, headerFields: nil)
        var session = MockURLSession(data: data, urlResponse: urlResponse, error: nil)
        let client = HTTPClient(session: session)
        
        let url = URL(string: "http://localhost:8080")!
        session.url = url
        
        // WHEN
        client.get(url) { (_, _) -> Void in }
        
        // THEN
        XCTAssertEqual(session.url, url)
    }

    func testGet_WithErrorReturned_ShouldReturnError() {
        // GIVEN
        let url = URL(string: "http://localhost:8080")!
        let data: Data = JsonHelpers.getJsonFile("response")!
        let expectedError = FetcherAppError.unknownError("")
        let urlResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!, statusCode: 200,
                                          httpVersion: nil, headerFields: nil)
        let session = MockURLSession(data: nil, urlResponse: urlResponse,
                                      error: expectedError)
        session.url = url
        session.error = expectedError
        let client = HTTPClient(session: session)
        
        // WHEN
        var error: Error?
        client.get(url) { (data, theError) -> Void in
            error = theError
        }
        
        // THEN
        XCTAssertNotNil(error)
    }
    /*
    func test_GET_StartsTheRequest() {
        // GIVEN
        
        // WHEN
        client.get(URL(fileURLWithPath: "/path/")) { (_, _) -> Void in }
        
        // THEN
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_GET_WithResponseData_AndA200StatusCode_ReturnsTheData() {
        // GIVEN
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.data = expectedData
        session.nextResponse = HTTPURLResponse(statusCode: 200)
        
        // WHEN
        var actualData: Data?
        client.get(URL(fileURLWithPath: "/some-path/")) { (data, _) -> Void in
            actualData = data
        }
        
        // THEN
        XCTAssertEqual(actualData, expectedData)
    }
    
    func test_GET_WithANetworkError_ReturnsANetworkError() {
        // GIVEN
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        // WHEN
        var error: Error?
        client.get(URL(fileURLWithPath: "/some-path/")) { (_, theError) -> Void in
            error = theError
        }
        
        // THEN
        XCTAssertNotNil(error)
    }
    
    func test_GET_WithResponseDataAndANetworkError_ReturnsAnError() {
        // GIVEN
        session.nextData = "{}".data(using: String.Encoding.utf8)
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        // WHEN
        var error: Error?
        client.get(URL(fileURLWithPath: "/some-path/")) { (data, theError) -> Void in
            XCTAssertNil(data)
            error = theError
        }
        
        // THEN
        XCTAssertNotNil(error)
    }
    
    func test_GET_WithAStatusCodeLessThan200_ReturnsAnError() {
        // GIVEN
        session.nextResponse = HTTPURLResponse(statusCode: 199)
        
        // WHEN
        var error: Error?
        client.get(URL(fileURLWithPath: "/some-path/")) { (data, theError) -> Void in
            XCTAssertNil(data)
            error = theError
        }
        
        // THEN
        XCTAssertNotNil(error)
    }
    
    func test_GET_WithAStatusCodeGreaterThan299_ReturnsAnError() {
        // GIVEN
        session.nextResponse = HTTPURLResponse(statusCode: 300)
        
        // WHEN
        var error: Error?
        client.get(URL(fileURLWithPath: "/some-path/")) { (data, theError) -> Void in
            XCTAssertNil(data)
            error = theError
        }
        
        // THEN
        XCTAssertNotNil(error)
    }
    */
}
