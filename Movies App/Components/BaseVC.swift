//
//  BaseVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import UIKit

class BaseVC: UIViewController {
    
    func presentErrorAlert(_ error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showLoading(_ state: Bool) {
        print("TEST --> Loading: \(state)")
        // TODO: Kaan - loading animation
    }
}
