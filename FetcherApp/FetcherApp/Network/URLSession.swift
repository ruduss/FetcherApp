//
//  URLSession.swift
//  FetcherApp
//
//  Created by nicole ruduss on 18/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    /**
     Creates a task that retrieves the contents of the specified URL
     - parameters:
     - url: The URL to be retrieved.
     - return value:
     - The new session data task URLSessionDataTask.
     */
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    /**
     Creates a task that retrieves the contents of the specified URL
     - parameters:
     - url: The URL to be retrieved.
     - return value:
     - The new session data task URLSessionDataTask.
     */
    func dataTaskWithUrl(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTaskWithUrl(_ url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        let task = dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return task as URLSessionDataTaskProtocol
    }
}

