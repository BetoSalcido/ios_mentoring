//
//  WishlistCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 23/04/24.
//

import Foundation
import Combine
import UIKit

protocol WishlistCellViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: WishlistCellViewModel, didSelectTour tour: NetworkingService.Tour)
    func viewModelDidRequestReload(_ viewModel: WishlistCellViewModel)
}

class WishlistCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    @Published private(set) var isFavoriteButtonSelected: Bool = false
    
    private lazy var userDefaultsService = serviceProvider.userDefaultsService
    private let serviceProvider: ServiceProvider
    private let tour: NetworkingService.Tour
    
    weak var delegate: WishlistCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: NetworkingService.Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
    }
}

// MARK: - Private Methods
private extension WishlistCellViewModel {
    
    func applyBindings() {
        titleText = tour.name
        reviewText = "\(tour.rating)"
        validateFavorite()
    }
    
    func validateFavorite() {
        isFavoriteButtonSelected = userDefaultsService.validateTour(tour: tour)
    }
}

// MARK: - Handler Methods
extension WishlistCellViewModel {
    
    func handleSelection() {
        delegate?.viewModel(self, didSelectTour: tour)
    }
    
    func handleFavoriteSelection() {
        if isFavoriteButtonSelected {
            isFavoriteButtonSelected = false
            userDefaultsService.removeTour(tour: tour)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("didRequestReload"), object: nil)
            }
        } else {
            isFavoriteButtonSelected = true
            
        }
        
        delegate?.viewModelDidRequestReload(self)
        
    }
}

// MARK: - CellViewModel
extension WishlistCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "WishlistCell"
    }
}
