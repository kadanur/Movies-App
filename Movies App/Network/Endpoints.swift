//
//  Endpoints.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseUrl: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HttpMethod { get }
    var request: URLRequest { get }
}

enum Endpoint {
    case searchMovie(searchText: String)
    case getMovie(imdbId: String)
}

extension Endpoint: EndpointProtocol {
    
    private enum QueryKeys: String {
        case apiKey = "apikey"
        case search = "s"
        case imdbId = "i"
    }
    
    var baseUrl: String {
        return "http://www.omdbapi.com"
    }
    
    var queryItems: [URLQueryItem] {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else { return [] }
        var items: [URLQueryItem] = [.init(name: QueryKeys.apiKey.rawValue, value: apiKey)]
        
        switch self {
        case let .searchMovie(searchText):
            items.append(.init(name: QueryKeys.search.rawValue, value: searchText))
        case let .getMovie(imbdId):
            items.append(.init(name: QueryKeys.imdbId.rawValue, value: imbdId))
        }
        
        return items
    }
    
    var method: HttpMethod {
        .get
    }
    
    var request: URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("URLComponents could not init")
        }
        
        component.queryItems = queryItems
    
        var request = URLRequest(url: component.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
}
