//
//  UIView+Extension.swift
//  TheMovieDB
//
//  Created by Victor Luni on 05/10/20.
//

import UIKit
extension UIView {
    func startActivityIndicator(activityView: UIActivityIndicatorView) {
        
        let activity = activityView
        activity.style = .large
        activity.color = .white
        
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = .clear

        
        activity.center = self.center
        container.addSubview(activity)
        self.addSubview(container)
        activity.startAnimating()
    }
    
    func stopActivityIndicator(activityView: UIActivityIndicatorView) {
        activityView.stopAnimating()
    }
    
}
