//
//  SplashCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import UIKit

final class SplashCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc: SplashVC = .instantiate()
        vc.coordinator = self
        vc.viewModel = SplashVM()
        
        navigationController.pushViewController(vc, animated: true)
    }
}
