//
//  SplashVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import Reachability
import UIKit

final class SplashVC: UIViewController {
    
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
        
        remoteConfig.fetchCloudValues { result in
            switch result {
            case .success(let success):
                print("TEST --> \(remoteConfig.getStringValue(forKey: .splashTitle))")
            case .failure(let failure):
                print("TEST --> \(failure.localizedDescription)")
            }
        }
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

extension SplashVC: SplashVMDelegate {
    
    func handleVMOutput(_ output: SplashVMOutput) {
        switch output {
            
        }
    }
}

private extension SplashVC {
    
    func setupReachability() {
        reachability?.whenReachable = { _ in
            print("TEST --> Reachable")
        }
        
        reachability?.whenUnreachable = { _ in
            print("TEST --> Unreachable")
        }
    }
}
