//
//  MovieDetailViewController.swift
//  TableView
//
//  Created by Beto Salcido on 24/10/23.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private var movieView: UIView!
    @IBOutlet private var movieImage: UIImageView!
    
    @IBOutlet private var movieTitleView: UIView!
    @IBOutlet private var movieTitleLabel: UILabel!
    
    @IBOutlet private var movieCategoryView: UIView!
    @IBOutlet private var movieCategoryLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Método para validar que la pelícua a sido proporcionada al viewController
        guard movie != nil else {
            assertionFailure("`movie` is required for \(Self.self) to work.")
            return
        }
        
        configureView()
    }

}

// MARK: - Private Methods
private extension MovieDetailViewController {
    
    func configureView() {
        self.title = movie.name
        
        movieView.layer.cornerRadius = 12
        movieImage.image = UIImage(named: movie.imageURL)
        
        movieTitleView.layer.cornerRadius = 12
        movieTitleLabel.text = movie.name
        
        movieCategoryView.layer.cornerRadius = 12
        movieCategoryLabel.text = movie.type
    }
}
