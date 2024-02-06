//
//  SplashVMProtocols.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

protocol SplashVMProtocol {
    var delegate: SplashVMDelegate? { get set }
    
    func handleVMInput(_ input: SplashVMInput)
}

protocol SplashVMDelegate: AnyObject {
    func handleVMOutput(_ output: SplashVMOutput)
}

enum SplashVMInput {
    case load
}

enum SplashVMOutput {
    case updateSplashTitle(text: String)
    case navigateToHome
    case presentError(message: String)
    case showLoading(Bool)
}
