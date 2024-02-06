//
//  Endpoints.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

private let apiKey = "fc3ede5e"

protocol EndpointProtocol {
    var baseUrl: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HttpMethod { get }
    var request: URLRequest { get }
}

enum EndPoint {
    case searchMovie(searchText: String)
    case getMovie(imdbId: String)
}

extension EndPoint: EndpointProtocol{
    
    var baseUrl: String {
        return "http://www.omdbapi.com"
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [.init(name: "apikey", value: apiKey)]
        
        switch self {
        case let .searchMovie(searchText):
            items.append(.init(name: "s", value: searchText))
        case let .getMovie(imbdId):
            items.append(.init(name: "i", value: imbdId))
        }
        
        return items
    }
    
    var method: HttpMethod {
        .get
    }
    
    var request: URLRequest {
        guard var component = URLComponents(string: baseUrl) else{
            fatalError("URLComponents could not init")
        }
        
        component.queryItems = queryItems
    
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        return request
    }
}
