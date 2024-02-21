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
    // Nothing to do yet.
}

class TourCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    
    private let serviceProvider: ServiceProvider
    private let tour: Tour
    weak var delegate: TourCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
    }
}

// MARK: - Private Methods
private extension TourCellViewModel {
    
    func applyBindings() {
        titleText = tour.name
        reviewText = "\(tour.reviews)"
    }
}

// MARK: - CellViewModel
extension TourCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "TourCell"
    }
}
