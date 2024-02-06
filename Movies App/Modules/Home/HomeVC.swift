//
//  HomeVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import UIKit

final class HomeVC: BaseVC {
    
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.request(.searchMovie(searchText: "Fast")) { (response: Result<SearchResponse, Error>) in
            
            switch response {
            case let .success(results):
                print(results.results)
            case let .failure(error):
                print("TEST --> \(error.localizedDescription)")
            }
        }
    }
}
