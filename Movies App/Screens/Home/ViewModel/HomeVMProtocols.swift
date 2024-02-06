//
//  HomeVMProtocols.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

protocol HomeVMProtocol {
    var delegate: HomeVMDelegate? { get set }
    
    func handleVMInput(_ input: HomeVMInput)
}

protocol HomeVMDelegate: AnyObject {
    func handleVMOutput(_ output: HomeVMOutput)
}

enum HomeVMInput {
    case searchBarTextDidChange(searchText: String)
}

enum HomeVMOutput {
    case updateState(HomeState)
    case presentErrorAlert(Error)
    case showLoading(Bool)
}

enum HomeState {
    case info(info: String)
    case list(movies: [SearchResult])
}
