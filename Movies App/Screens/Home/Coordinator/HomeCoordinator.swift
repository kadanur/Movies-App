//
//  HomeCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc: HomeVC = .instantiate()
        let repository = HomeRepository(networkManager: NetworkManager())
        let viewModel = HomeVM(repository: repository)
        
        vc.coordinator = self
        vc.viewModel = viewModel
        vc.isBackButtonHide = true
        rootViewController = vc
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetail(imdbId: String?) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start(imdbId: imdbId)
    }
}
