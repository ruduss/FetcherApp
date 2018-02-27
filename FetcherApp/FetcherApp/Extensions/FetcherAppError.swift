//
//  Error.swift
//  FetcherApp
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation

enum FetcherAppError: Error {
    case invalidURL()
    case networkError(_: String?)
    case parsingError(_: String?)
    case serialisationError(_: String?)
    case noData(_: String?)
    case unknownError(_: String?)
}
