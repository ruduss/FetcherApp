//
//  MockFetcherParser.swift
//  FetcherAppTests
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation
@testable import FetcherApp

class MockCodeResponseSerialiser: SerialiserProtocol {
    var responseCode: UUID = UUID()
    
    func serialise(_ data: Data) throws -> AnyObject? {
        
        return CodeResponse(path: "d", responseCode: self.responseCode) as AnyObject
    }
}

class MockRootPageSerialiser: SerialiserProtocol {
    func serialise(_ data: Data) throws -> AnyObject? {
        
        return RootPageResponse(nextPath: "nextPath")
    }
}

class MockSerialiserThrowsError: SerialiserProtocol {
    var responseCode: UUID = UUID()
    
    func serialise(_ data: Data) throws -> AnyObject? {
        
        throw FetcherAppError.networkError("")
    }
}

class MockSerialiserReturnsNil: SerialiserProtocol {
    var responseCode: UUID = UUID()
    
    func serialise(_ data: Data) throws -> AnyObject? {
        
        return nil
    }
}
