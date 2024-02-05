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
            break
        }
    }
}
