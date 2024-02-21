//
//  RecommendedCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import Combine
import UIKit

protocol RecommendedCellViewModelDelegate: AnyObject {
    // Nothing to do yet.
}

class RecommendedCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var descriptionText: String?
    
    private let serviceProvider: ServiceProvider
    private let tour: Tour
    weak var delegate: RecommendedCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
    }
}

// MARK: - Private Methods
private extension RecommendedCellViewModel {
    
    func applyBindings() {
        titleText = tour.name
        descriptionText = tour.shortDescription
    }
}

// MARK: - CellViewModel
extension RecommendedCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "RecommendedCell"
    }
}
