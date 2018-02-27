//
//  CodeResponse.swift
//  FetcherApp
//
//  Created by nicole ruduss on 17/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

protocol ResponseProtocol {
    
}

class CodeResponse: NSObject, ResponseProtocol {
    public private(set) var path: String
    public private(set) var responseCode: UUID
    
    init(path: String, responseCode: UUID) {
        self.path = path
        self.responseCode = responseCode
    }
}
