//
//  NSObject+Extension.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import Foundation

extension NSObject {
    
    static var className: String {
        String(describing: self)
    }
}
