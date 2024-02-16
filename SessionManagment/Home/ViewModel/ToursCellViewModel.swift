//
//  ToursCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation
import Combine
import UIKit

protocol ToursCellViewModelDelegate: AnyObject {
    // Nothing to do yet.
}

class ToursCellViewModel {
    
    /// Binding
    @Published private(set) var title: String?
    
    private let serviceProvider: ServiceProvider
    private let tours: [Tour]
    
    weak var delegate: ToursCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tours: [Tour]) {
        self.serviceProvider = serviceProvider
        self.tours = tours
        applyBindings()
    }
}

// MARK: - Private Methods
private extension ToursCellViewModel {
    
    func applyBindings() {
        // Nothing to do yet.
    }
}

// MARK: - CellViewModel
extension ToursCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "ToursCell"
    }
}
