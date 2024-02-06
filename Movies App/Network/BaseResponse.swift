//
//  BaseResponse.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import Foundation

protocol BaseResponse where Self: Decodable {
    var error: String? { get set }
    var response: String? { get set }
}
