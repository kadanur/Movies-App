//
//  MovieDetailVC.swift
//  Movies App
//
//  Created by M Kaan Adanur on 7.02.2024.
//

import SDWebImage
import UIKit

final class MovieDetailVC: BaseVC {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var actorsLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var imdbRatingLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    
    private var movieDetail: MovieDetail? {
        didSet {
            updateUI()
        }
    }
    
    weak var coordinator: MovieDetailCoordinator?
    
    var viewModel: MovieDetailVMProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.handleVMInput(.load)
    }
}

private extension MovieDetailVC {
    
    func updateUI() {
        guard let movieDetail else { return }
        
        if let posterUrl = URL(string: movieDetail.imageUrl ?? "") {
            posterImageView.sd_setImage(with: posterUrl, placeholderImage: .init(systemName: "photo")) { [weak self] _, _, _ in
                self?.posterImageView.contentMode = .scaleAspectFill
            }
        }
        
        if let movieTitle = movieDetail.title {
            title = movieTitle
        }
        
        setLabel(to: titleLabel, from: movieDetail.title)
        setLabel(to: directorLabel, from: movieDetail.director)
        setLabel(to: actorsLabel, from: movieDetail.actors)
        setLabel(to: genreLabel, from: movieDetail.genre)
        setLabel(to: durationLabel, from: movieDetail.duration)
        setLabel(to: imdbRatingLabel, from: movieDetail.imdbRating)
        setLabel(to: yearLabel, from: movieDetail.year)
        setLabel(to: plotLabel, from: movieDetail.plot)
    }
    
    func setLabel(to label: UILabel, from text: String?) {
        guard let text else { return }
        
        label.text = text
        label.isHidden = false
    }
}

extension MovieDetailVC: MovieDetailVMDelegate {
    
    func handleVMOutput(_ output: MovieDetailVMOutput) {
        switch output {
        case let .updateMovieDetail(movieDetail):
            self.movieDetail = movieDetail
        case let .presentError(message):
            presentErrorAlert(message: message, isPop: true)
        case let .showLoading(state):
            showLoading(state)
        }
    }
}
