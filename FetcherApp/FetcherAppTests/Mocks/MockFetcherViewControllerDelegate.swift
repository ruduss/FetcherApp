//
//  MockFetcherViewControllerDelegate.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit
@testable import FetcherApp

class MockFetcherViewControllerDelegate: FetcherViewControllerDelegate {
    var updateUICalled: Int = 0
    var errorResponseCalled: Int = 0
    var startRefreshingCalled: Int = 0
    var endRefreshingCalled: Int = 0
    
    func updateUI() {
        updateUICalled = updateUICalled + 1
    }
    
    func errorResponse() {
        errorResponseCalled = errorResponseCalled + 1
    }
}
