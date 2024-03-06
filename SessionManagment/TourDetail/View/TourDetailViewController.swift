//
//  TourDetailViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import UIKit

class TourDetailViewController: UIViewController {
    
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var bookButton: UIButton!
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var favoriteImage: UIImageView!
    @IBOutlet private var favoriteView: UIView!
    @IBOutlet private var readMoreButton: UIButton!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var internetView: UIView!
    @IBOutlet private var dinnerView: UIView!
    @IBOutlet private var tubView: UIView!
    @IBOutlet private var poolView: UIView!
    
    private var bindings = Bindings()
    
    var viewModel: TourDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureView()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private Methods
private extension TourDetailViewController {
    
    func configureView() {
        readMoreButton.semanticContentAttribute = .forceRightToLeft
        
        bookButton.semanticContentAttribute = .forceRightToLeft
        bookButton.layer.cornerRadius = 10
        
        backgroundImage.layer.cornerRadius = 20
        
        favoriteView.layer.cornerRadius = favoriteView.frame.width / 2
        favoriteView.clipsToBounds = true
        
        internetView.layer.cornerRadius = 15
        dinnerView.layer.cornerRadius = 15
        tubView.layer.cornerRadius = 15
        poolView.layer.cornerRadius = 15
        
    }
    
    func configureBindings() {
        viewModel.$descriptionText
            .assign(to: \.text, on: descriptionLabel)
            .store(in: &bindings)
        
        viewModel.$descriptionNumberOfLines
            .sink { [descriptionLabel] in
                descriptionLabel?.numberOfLines = $0 ?? 4
            }
            .store(in: &bindings)
        
        viewModel.$isReadMoreButtonTapped
            .sink { [readMoreButton] in
                let imageName = $0 ? UIImage(named: "ArrowUp") : UIImage(named: "ArrowDown")
                readMoreButton?.setImage(imageName, for: .normal)
            }
            .store(in: &bindings)
        
        viewModel.$isFavoriteButtonSelected
            .sink { [favoriteImage] in
                let image = UIImage(named: "Favorite")
                favoriteImage?.image = UIImage(named: "Favorite")
                favoriteImage?.tintColor = $0 ? .red : .lightGray
            }
            .store(in: &bindings)
    }
}

// MARK: - Action Methods
private extension TourDetailViewController {
    
    @IBAction func didTapBookButton(_ sender: Any) {
        print("Button selected!")
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapReadMoreButton(_ sender: Any) {
        viewModel.handleReadMoreSelection()
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        viewModel.handlerFavoriteButtonSelection()
    }
}

// MARK: - StoryboardInitializable
extension TourDetailViewController: StoryboardInitializable {
    static let storyboardName = "TourDetail"
}
