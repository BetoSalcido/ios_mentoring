//
//  TourCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation
import Combine
import UIKit

protocol TourCellViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: TourCellViewModel, didSelectTour tour: NetworkingService.Tour)
}

class TourCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    @Published private(set) var imageURL: URL?
    @Published private(set) var isFavoriteButtonSelected: Bool = false
    
    private let serviceProvider: ServiceProvider
    private lazy var userDefaultsService = serviceProvider.userDefaultsService
    private let tour: NetworkingService.Tour
    weak var delegate: TourCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: NetworkingService.Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
        validateFavorite()
    }
}

// MARK: - Private Methods
private extension TourCellViewModel {
    
    func applyBindings() {
        titleText = tour.name
        reviewText = "\(tour.rating)"
        imageURL = URL(string: tour.imageURL)
    }
    
    func validateFavorite() {
        isFavoriteButtonSelected = userDefaultsService.validateTour(tour: tour)
    }
}

// MARK: - Handler Methods
extension TourCellViewModel {
    
    func handleSelection() {
        delegate?.viewModel(self, didSelectTour: tour)
    }
    
    func handleFavoriteSelection() {
        if isFavoriteButtonSelected {
            userDefaultsService.removeTour(tour: tour)
            isFavoriteButtonSelected = false
        } else {
            userDefaultsService.addTour(tour: tour)
            isFavoriteButtonSelected = true
        }
    }
}

// MARK: - CellViewModel
extension TourCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "TourCell"
    }
}
