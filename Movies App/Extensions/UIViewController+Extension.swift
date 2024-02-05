//
//  UIViewController+Extension.swift
//  Movies App
//
//  Created by M Kaan Adanur on 5.02.2024.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T: UIViewController>() -> T {
        let className = String(describing: T.self)
        
        return T(nibName: className, bundle: nil)
    }
}
