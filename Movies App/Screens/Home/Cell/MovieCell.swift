//
//  MovieCell.swift
//  Movies App
//
//  Created by M Kaan Adanur on 6.02.2024.
//

import SDWebImage
import UIKit

final class MovieCell: UITableViewCell {
    
    @IBOutlet private weak var bodyView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    
    var onTapAction: ((_ movie: SearchResult) -> Void)?
    
    var movie: SearchResult? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        addGestures()
    }
}

private extension MovieCell {
    
    func addGestures() {
        let didTapBodyViewGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBodyView))
        bodyView.addGestureRecognizer(didTapBodyViewGesture)
    }
    
    func setupUI() {
        bodyView.layer.cornerRadius = 20
        posterImageView.layer.cornerRadius = 20
    }
    
    func updateUI() {
        guard let movie else { return }

        if let posterUrl = URL(string: movie.image ?? "") {
            posterImageView.sd_setImage(with: posterUrl, placeholderImage: .init(systemName: "photo")) { [weak self] _,_,_,_ in
                self?.posterImageView.contentMode = .scaleAspectFill
            }
        }
        
        nameLabel.text = movie.title
        yearLabel.text = "Year: \(String(describing: movie.year ?? ""))"
    }
    
    @objc func didTapBodyView() {
        guard let movie else { return }
        onTapAction?(movie)
    }
}
