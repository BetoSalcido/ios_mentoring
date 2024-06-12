//
//  WishlistViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 06/03/24.
//

import Foundation
import UIKit

class WishlistViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var emptyStateStackView: UIStackView!
    @IBOutlet private var homeButton: UIButton!
    
    private var bindings = Bindings()
    
    var viewModel: WishlistViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wishlist"
        
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        homeButton.layer.cornerRadius = 10
        configureBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.handleViewDidAppear()
    }
}

// MARK: - Private Methods
private extension WishlistViewController {
    
    func configureBindings() {
        
        viewModel.$isEmptyStateHidden
            .sink { [emptyStateStackView, tableView] in
                emptyStateStackView?.isHidden = $0
                tableView?.isHidden = !$0
            }
            .store(in: &bindings)
        
        viewModel.reloadData
            .sink { [tableView] in
                tableView?.reloadData()
            }
            .store(in: &bindings)
        
    }
}

// MARK: - Actions Methods
private extension WishlistViewController {
    
    @IBAction func didTapHomeButton(_ sender: Any) {
        sceneDelegate.selectTabBarItem(withIndex: 0)
    }
}

// MARK: - UITableViewDataSource
extension WishlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCellViewModels
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        if let configurable = cell as? CellViewModelConfigurable {
            configurable.configure(cellViewModel: cellViewModel)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WishlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.cellViewModel(at: indexPath) as? WishlistCellViewModel else {
            return
        }
        
        cellViewModel.handleSelection()
    }
}

// MARK: - WishlistViewModelDelegate
extension WishlistViewController: WishlistViewModelDelegate {
    
    func viewModel(_ viewModel: WishlistViewModel, didSelectTour tour: NetworkingService.Tour) {
        let viewModel = TourDetailViewModel(serviceProvider: viewModel.serviceProvider, tour: tour)
        let viewController = TourDetailViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - StoryboardInitializable
extension WishlistViewController: StoryboardInitializable {
    static let storyboardName = "Wishlist"
}
