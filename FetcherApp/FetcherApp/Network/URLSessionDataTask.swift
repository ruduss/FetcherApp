//
//  URLSessionDataTask.swift
//  FetcherApp
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import Foundation

import UIKit

protocol URLSessionDataTaskProtocol {
    /**
     Resumes the task
     */
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
