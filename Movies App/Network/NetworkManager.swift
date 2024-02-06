//
//  NetworkManager.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Alamofire
import Foundation

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        _ endpoint: EndPoint,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(
        _ endpoint: EndPoint ,
        completion: @escaping (Result<T, Error>) -> Void) {
            AF.request(endpoint.request)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
}
