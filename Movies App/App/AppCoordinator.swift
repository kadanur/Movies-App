//
//  AppCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private var window: UIWindow
    
    init(with window: UIWindow) {
        navigationController = .init()
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let coordinator = SplashCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}
