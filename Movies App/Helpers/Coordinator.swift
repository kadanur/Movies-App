//
//  Coordinator.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import UIKit

@objc protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var rootViewController: UIViewController? { get set }
    
    @objc optional func start()
}

extension Coordinator {
    
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func checkInChildFinish(from viewController: UIViewController) -> Bool {
        for coordinator in childCoordinators {
            if coordinator.childCoordinators.isEmpty, coordinator.rootViewController == viewController {
                return childDidFinish(coordinator)
            } else {
                if coordinator.checkInChildFinish(from: viewController) {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func childDidFinish(_ child: Coordinator?) -> Bool {
        guard let index = childCoordinators.firstIndex(where: { $0 === child }) else { return false}
        childCoordinators.remove(at: index)
        
        return true
    }
}
