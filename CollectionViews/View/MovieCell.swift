//
//  MovieCell.swift
//  CollectionViews
//
//  Created by Beto Salcido on 01/11/23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet private var bodyView: UIView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var actorLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var movieImage: UIImageView!
    @IBOutlet private var downloadImage: UIImageView!
    @IBOutlet private var circleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10
        bodyView.applyShadow()
    }
    
    func configureCell(with movie: Movie) {
        nameLabel.text = movie.name
        actorLabel.text = movie.actor
        typeLabel.text = movie.type
        movieImage.image = UIImage(named: movie.imageURL)
        downloadImage.image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        circleImage.image = UIImage(systemName: "dot.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }
}
