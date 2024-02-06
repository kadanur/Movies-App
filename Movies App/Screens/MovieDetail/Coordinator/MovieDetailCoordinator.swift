//
//  MovieDetailCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc: MovieDetailVC = .instantiate()
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: true)
    }
}
