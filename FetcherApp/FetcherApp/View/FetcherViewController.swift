//
//  ViewController.swift
//  FetcherApp
//
//  Created by nicole ruduss on 17/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

protocol FetcherViewControllerDelegate: class {
    func updateUI()
    func errorResponse()
}

class FetcherViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var numberOfTimesLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Properties
    var viewModel: FetcherViewModel!
    weak var vmDelegate: FetcherViewModelDelegate?
    var activitySpinner: ActivitySpinnerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.viewModel == nil {
            self.viewModel = FetcherViewModel(vcDelegate: self)
        }
        self.vmDelegate = self.viewModel
    }
    
    func startRefreshing() {
        guard self.activitySpinner == nil else {
            return
        }
        self.activitySpinner = ActivitySpinnerView(frame: self.contentView.bounds)
        self.contentView.addSubview(self.activitySpinner!)
        self.contentView.isUserInteractionEnabled = false
    }
    
    func endRefreshing() {
        if let activitySpinner = self.activitySpinner {
            DispatchQueue.main.async {
                self.contentView.isUserInteractionEnabled = true
                activitySpinner.removeFromSuperview()
            }
            self.activitySpinner = nil
        }
    }
    
    // MARK: - Button interractions
    @IBAction func fetchNewContentButtonPressed(_ sender: Any) {
        self.startRefreshing()
        self.vmDelegate?.fetchResults()
    }
}

extension FetcherViewController: FetcherViewControllerDelegate {
    
    func updateUI() {
        if let response = self.viewModel.codeResponse {
            DispatchQueue.main.async {
                self.counterLabel.text = response.responseCode.uuidString
                self.numberOfTimesLabel.text = String(self.viewModel.timesFetched)
            }
        }
        self.endRefreshing()
    }
    
    func errorResponse() {
        self.endRefreshing()
        let alert = UIAlertController(title: "Error", message: "error getting response code", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}