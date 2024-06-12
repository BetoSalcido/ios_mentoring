//
//  HomeViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private lazy var animationViewController = AnimationViewController()
    private var bindings = Bindings()
    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
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
    
    func runTourDetail(with  tour: NetworkingService.Tour) {
        let viewModel = TourDetailViewModel(serviceProvider: viewModel.serviceProvider, tour: tour)
        let viewController = TourDetailViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func displayAnimation() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            guard let self else { return }
            self.animationViewController.view.alpha = 1.0
        }) { [weak self] _ in
            guard let self else { return }
            addChild(self.animationViewController)
            view.addSubview(self.animationViewController.view)
            self.animationViewController.didMove(toParent: self)
        }
    }
    
    func removeAnimation() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            guard let self else { return }
            self.animationViewController.view.alpha = 0.0
        }) { [weak self] _ in
            guard let self else { return }
            self.animationViewController.willMove(toParent: nil)
            self.animationViewController.view.removeFromSuperview()
            self.animationViewController.removeFromParent()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.totalSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
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
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
//            return
//        }
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
//        if let configurable = cell as? CellViewModelConfigurable {
//            configurable.configureWillDisplayCell(cellViewModel: cellViewModel)
//        }
//    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    // Nothing to do yet.
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellViewModelSize = viewModel.cellViewModelSize(at: indexPath)
        return CGSize(width: view.frame.width, height: cellViewModelSize)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func viewModelRemoveLoadingView(_ viewModel: HomeViewModel) {
        removeAnimation()
    }
    
    func viewModelDisplayLoadingView(_ viewModel: HomeViewModel) {
        displayAnimation()
    }
    
    func viewModel(_ viewModel: HomeViewModel, didSelectTour tour: NetworkingService.Tour) {
        runTourDetail(with: tour)
    }
}

// MARK: - StoryboardInitializable
extension HomeViewController: StoryboardInitializable {
    static let storyboardName = "Home"
}
