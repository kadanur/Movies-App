//
//  BaseVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import FirebaseAnalytics
import UIKit

class BaseVC: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var transparentView: UIView?
    
    var isBackButtonHide: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationItem.setHidesBackButton(isBackButtonHide, animated: true)
    }
    
    func presentErrorAlert(message: String, isPop: Bool = false) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            if isPop {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showLoading(_ state: Bool) {
        state ? activityIndicatorBegin() : activityIndicatorEnd()
    }
    
    func sendAnalyticsEvent(name: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters)
    }
}

private extension BaseVC {
    
    func activityIndicatorBegin() {
        activityIndicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.color = UIColor(red: 0.17, green: 0.21, blue: 0.45, alpha: 1)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        transparentView = UIView(frame: .init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        transparentView?.backgroundColor = .white
        transparentView?.alpha = 0.3
        
        if let transparentView {
            self.view.addSubview(transparentView)
        }
        
        view.addSubview(activityIndicator)
    }
    
    func activityIndicatorEnd() {
        self.activityIndicator.stopAnimating()
        self.transparentView?.removeFromSuperview()
    }
}
