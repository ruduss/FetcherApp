//
//  ActivitySpinnerView.swift
//  FetcherApp
//
//  Created by nicole ruduss on 25/02/2018.
//  Copyright © 2018 nicole ruduss. All rights reserved.
//

import UIKit

class ActivitySpinnerView: UIView {
    
    var activitySpinner: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.activitySpinner.center = self.center;
        self.addSubview(self.activitySpinner)
        self.activitySpinner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
