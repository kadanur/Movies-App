//
//  SplashVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import Reachability
import UIKit

final class SplashVC: BaseVC {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityIndicatior: UIActivityIndicatorView!
    
    private let reachability = try? Reachability()
    
    weak var coordinator: SplashCoordinator?
    var viewModel: SplashVMProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReachability()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? reachability?.startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        reachability?.stopNotifier()
    }
}

private extension SplashVC {
    
    func setupReachability() {
        reachability?.whenReachable = { [weak self] _ in
            self?.titleLabel.text = ""
            self?.viewModel?.handleVMInput(.load)
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.titleLabel.text = "Please check your internet connection"
        }
    }
}

extension SplashVC: SplashVMDelegate {
    
    func handleVMOutput(_ output: SplashVMOutput) {
        switch output {
        case let .updateSplashTitle(text):
            titleLabel.text = text
        case .navigateToHome:
            coordinator?.navigateToHome()
        case let .presentError(message):
            presentErrorAlert(message: message)
        case let .showLoading(state):
            state ? activityIndicatior.startAnimating() : activityIndicatior.stopAnimating()
        }
    }
}
