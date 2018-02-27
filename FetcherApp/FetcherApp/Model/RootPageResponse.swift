//
//  NextPathResponse.swift
//  FetcherApp
//
//  Created by nicole ruduss on 21/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

class RootPageResponse: NSObject, ResponseProtocol {
    public private(set) var nextPath: String
    
    init(nextPath: String) {
        self.nextPath = nextPath
    }
}
