//
//  SplashVM.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

final class SplashVM: SplashVMProtocol {
    
    weak var delegate: SplashVMDelegate?
    
    func handleVMInput(_ input: SplashVMInput) {
        switch input {
        case .load:
            fetchRemoteConfig()
        }
    }
}

private extension SplashVM {
    
    func fetchRemoteConfig() {
        showLoading(true)
        remoteConfig.fetchCloudValues { [weak self] result in
            guard let self else { return }
            
            showLoading(false)
            
            switch result {
            case .success:
                updateSplashLabel()
                navigateToApp()
            case let .failure(error):
                delegate?.handleVMOutput(.presentError(message: error.localizedDescription))
            }
        }
    }
    
    func updateSplashLabel() {
        guard let text = remoteConfig.getStringValue(forKey: .splashTitle) else { return }
        delegate?.handleVMOutput(.updateSplashTitle(text: text))
    }
    
    func navigateToApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.delegate?.handleVMOutput(.navigateToHome)
        }
    }
    
    func showLoading(_ state: Bool) {
        delegate?.handleVMOutput(.showLoading(state))
    }
}
