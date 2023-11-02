//
//  TestingCell.swift
//  TableView
//
//  Created by Miguel Hernandez on 10/18/23.
//

import UIKit

class RowForSectionACell: UITableViewCell {

    @IBOutlet private var bodyView: UIView!
    @IBOutlet private var nameLable: UILabel!
    @IBOutlet private var actorLabel: UILabel!
    @IBOutlet private var typeLable: UILabel!
    @IBOutlet private var movieImage: UIImageView!
    @IBOutlet private var downloadImage: UIImageView!
    @IBOutlet private var circleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.layer.cornerRadius = 10
        bodyView.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with movie: Movie) {
        nameLable.text = movie.name
        actorLabel.text = movie.actor
        typeLable.text = movie.type
        movieImage.image = UIImage(named: movie.imageURL)
        downloadImage.image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        circleImage.image = UIImage(systemName: "dot.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    }
}
