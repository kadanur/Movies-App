//
//  RemoteConfigHelper.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import FirebaseRemoteConfigInternal
import Foundation

enum RemoteConfigKey: String {
    case splashTitle
}

protocol RemoteConfigHelperProtocol {
    func fetchCloudValues(completion: @escaping (Result<Bool, Error>) -> Void)
    func getStringValue(forKey key: RemoteConfigKey) -> String?
}

final class RemoteConfigHelper: RemoteConfigHelperProtocol {
    
    private let remoteConfig = RemoteConfig.remoteConfig()

    init() {
        setupSettings()
    }
    
    func fetchCloudValues(completion: @escaping (Result<Bool, Error>) -> Void) {
        remoteConfig.fetch { [weak self] _, error in
            guard let self else { return }
            
            if let error {
                completion(.failure(error))
                return
            }
            
            remoteConfig.activate { _, _ in
                completion(.success(true))
            }
        }
    }
    
    func getStringValue(forKey key: RemoteConfigKey) -> String? {
        remoteConfig[key.rawValue].stringValue
    }
}

private extension RemoteConfigHelper {
    
    func setupSettings() {
      let settings = RemoteConfigSettings()
        
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        settings.minimumFetchInterval = 43200
        #endif
        
      remoteConfig.configSettings = settings
    }
}
