//
//  SerialiserProtocol.swift
//  FetcherApp
//
//  Created by nicole ruduss on 21/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation

/**
 Serialises the request from the api into the valid object
 - parameters:
 - data: the data to serialise
 - returns:
 - AnyObject
 */
public protocol SerialiserProtocol {
    func serialise(_ data: Data) throws -> AnyObject?
}
