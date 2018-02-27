//
//  FetcherViewModelTests.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import XCTest
@testable import FetcherApp

class FetcherViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchResults_WithValidParams_ShouldReturnObject() {
        // GIVEN
        let mockFetcherService = MockFetcherService()
        let expectedResponseCode = UUID()
        mockFetcherService.returnResponseCode = expectedResponseCode
        let delegate = MockFetcherViewControllerDelegate()
        
        // WHEN
        let vm = FetcherViewModel(fetcherService: mockFetcherService, vcDelegate: delegate)
        vm.fetchResults()
        
        // THEN
        XCTAssert(mockFetcherService.getResponseCalled == 1)
        XCTAssert(delegate.updateUICalled == 1)
        XCTAssert(delegate.errorResponseCalled == 0)
    }
    
    func testFetchResults_WithInValidParams_ShouldError() {
        // GIVEN
        let mockFetcherService = MockFetcherService()
        let expectedResponseCode = UUID()
        mockFetcherService.returnResponseCode = expectedResponseCode
        mockFetcherService.error = FetcherAppError.unknownError(nil)
        let delegate = MockFetcherViewControllerDelegate()
        
        // WHEN
        let vm = FetcherViewModel(fetcherService: mockFetcherService, vcDelegate: delegate)
        vm.fetchResults()
        
        // THEN
        XCTAssert(mockFetcherService.getResponseCalled == 1)
        XCTAssert(delegate.errorResponseCalled == 1)
    }
}
