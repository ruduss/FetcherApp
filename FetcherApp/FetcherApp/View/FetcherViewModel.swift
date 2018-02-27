//
//  FetcherViewModel.swift
//  FetcherApp
//
//  Created by nicole ruduss on 17/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

protocol FetcherViewModelProtocol {
}

protocol FetcherViewModelDelegate: class {
    func fetchResults()
}

class FetcherViewModel: FetcherViewModelProtocol {
    
    var fetcherService: FetcherServiceProtocol!
    var codeResponse: CodeResponse?
    var timesFetched: Int
    var vcDelegate: FetcherViewControllerDelegate?
    
    init(fetcherService: FetcherServiceProtocol = FetcherService(), vcDelegate: FetcherViewControllerDelegate) {
        self.fetcherService = fetcherService
        self.timesFetched = 0
        self.vcDelegate = vcDelegate
    }
    
}

extension FetcherViewModel: FetcherViewModelDelegate {
    
    func fetchResults() {
        self.fetcherService.getResponse { (response, error) in
            if error != nil {
                self.vcDelegate?.errorResponse()
            } else if let response = response  {
                self.codeResponse = response
                self.timesFetched = self.timesFetched + 1
                self.vcDelegate?.updateUI()
            }
        }
    }
}
