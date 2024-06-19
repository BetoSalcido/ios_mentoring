//
//  WishlistViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 06/03/24.
//

import Foundation

protocol WishlistViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: WishlistViewModel, didSelectTour tour: NetworkingService.Tour)
}

class WishlistViewModel {
    
    /// Bindings
    @Published private(set) var isEmptyStateHidden: Bool = true
    
    private lazy var userDefaultsService = serviceProvider.userDefaultsService
    private var cellViewModels = [WishlistCellViewModel]()
    private(set) lazy var savedTours = userDefaultsService.tours
    private(set) var serviceProvider: ServiceProvider
    
    let reloadData = Command<Void>()
    
    weak var delegate: WishlistViewModelDelegate?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
}

// MARK: - Private Methods
private extension WishlistViewModel {
    
    func validateInformation() {
        let tours = userDefaultsService.tours
        
        if !tours.isEmpty {
            cellViewModels = tours.map({ tour in
                let cellViewModel = WishlistCellViewModel(serviceProvider: serviceProvider, tour: tour)
                cellViewModel.delegate = self
                return cellViewModel
            })
            
            isEmptyStateHidden = true
            reloadData.send()
        } else {
            isEmptyStateHidden = false
        }
    }
}

// MARK: - Public Methods
extension WishlistViewModel {
    
    var totalCellViewModels: Int {
        return cellViewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> CellViewModel? {
        let rows = cellViewModels
        let indexRow = indexPath.row
        guard rows.indices.contains(indexRow) else {
            return nil
        }
        
        return rows[indexRow]
    }
}

// MARK: - Handler Methods
extension WishlistViewModel {
    
    func handleViewDidAppear() {
        validateInformation()
    }
}

// MARK: - WishlistCellViewModelDelegate
extension WishlistViewModel: WishlistCellViewModelDelegate {
    
    func viewModelDidRequestReload(_ viewModel: WishlistCellViewModel) {
        validateInformation()
    }
    
    func viewModel(_ viewModel: WishlistCellViewModel, didSelectTour tour: NetworkingService.Tour) {
        delegate?.viewModel(self, didSelectTour: tour)
    }
}
