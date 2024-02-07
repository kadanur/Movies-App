//
//  AppCoordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?
    
    private var window: UIWindow
    
    init(with window: UIWindow) {
        navigationController = .init()
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        super.init()
        navigationController.delegate = self
    }
    
    func start() {
        let coordinator = SplashCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let fromViewController = navigationController
            .transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        checkInChildFinish(from: fromViewController)
    }
}
