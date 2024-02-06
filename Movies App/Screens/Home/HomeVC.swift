//
//  HomeVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import UIKit

final class HomeVC: BaseVC {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var state: HomeState = .info(info: "Please, search for movies.")
    private var movies: [SearchResult] = []
    private var timer: Timer?
    
    weak var coordinator: HomeCoordinator?
    
    var viewModel: HomeVMProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

private extension HomeVC {
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Please, search for movies"
        navigationItem.searchController = searchController
    }
    
    func updateState(_ homeState: HomeState) {
        state = homeState
        
        switch state {
        case let .list(movies):
            self.movies = movies
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @objc func textDidChange() {
        guard let searchText = navigationItem.searchController?.searchBar.text else { return }
        viewModel?.handleVMInput(.searchBarTextDidChange(searchText: searchText))
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .info:
            return 1
        case .list:
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch state {
        case let .info(info):
            cell.textLabel?.text = "\(info)"
        case .list:
            cell.textLabel?.text = "\(movies[indexPath.row].title)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .list = state else { return }
    }
}

extension HomeVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(textDidChange),
            userInfo: nil,
            repeats: false
        )
    }
}

extension HomeVC: HomeVMDelegate {
    
    func handleVMOutput(_ output: HomeVMOutput) {
        switch output {
        case let .updateState(state):
            updateState(state)
        case let .presentErrorAlert(error):
            presentErrorAlert(error)
        case let .showLoading(state):
            showLoading(state)
        }
    }
}
