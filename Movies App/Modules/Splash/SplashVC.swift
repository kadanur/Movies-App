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
    
    private let reachability = try? Reachability()
    private var isInternetConnectionReachable = false
    
    weak var coordinator: SplashCoordinator?
    var viewModel: SplashVMProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReachability()
        viewModel?.handleVMInput(.load)
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
            self?.isInternetConnectionReachable = true
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.isInternetConnectionReachable = false
        }
    }
}

extension SplashVC: SplashVMDelegate {
    
    func handleVMOutput(_ output: SplashVMOutput) {
        switch output {
        case let .updateSplashTitle(text):
            titleLabel.text = text
        case .navigateToHome:
            coordinator?.start()
        case let .presentError(error):
            presentErrorAlert(error)
        case let .showLoading(state):
            showLoading(state)
        }
    }
}
