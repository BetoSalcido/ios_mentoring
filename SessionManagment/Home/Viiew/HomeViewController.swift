//
//  HomeViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var bindings = Bindings()
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Validation to make sure that the viewModel is added to the viewController.
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureBindings()
        viewModel.handleViewDidLoad()
    }
}

// MARK: - Private Extension
private extension HomeViewController {
    
    func configureBindings() {
        viewModel.reloadData
            .sink { [collectionView] in
                collectionView?.reloadData()
            }
            .store(in: &bindings)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        if let configurable = cell as? CellViewModelConfigurable {
            configurable.configure(cellViewModel: cellViewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
            return
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        if let configurable = cell as? CellViewModelConfigurable {
            configurable.configureWillDisplayCell(cellViewModel: cellViewModel)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    // Nothing to do yet
}

// MARK: - StoryboardInitializable
extension HomeViewController: StoryboardInitializable {
    static let storyboardName = "Home"
}
