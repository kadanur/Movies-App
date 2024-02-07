//
//  MovieDetailVMProtocols.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import Foundation

protocol MovieDetailVMProtocol {
    var delegate: MovieDetailVMDelegate? { get set }
    
    func handleVMInput(_ input: MovieDetailVMInput)
}

protocol MovieDetailVMDelegate: AnyObject {
    func handleVMOutput(_ output: MovieDetailVMOutput)
}

enum MovieDetailVMInput {
    case load
}

enum MovieDetailVMOutput {
    case updateMovieDetail(MovieDetail)
    case sendAnalyticsEvent(name: String, parameters: [String: Any]?)
    case presentError(message: String)
    case showLoading(Bool)
}
