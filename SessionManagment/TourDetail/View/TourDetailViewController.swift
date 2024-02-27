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
        bookButton.semanticContentAttribute = .forceRightToLeft
        bookButton.layer.cornerRadius = 10
        
        backgroundImage.layer.cornerRadius = 20
        
        favoriteView.layer.cornerRadius = favoriteView.frame.width / 2
        favoriteView.clipsToBounds = true
    }
    
    func configureBindings() {
        
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
}

// MARK: - StoryboardInitializable
extension TourDetailViewController: StoryboardInitializable {
    static let storyboardName = "TourDetail"
}
