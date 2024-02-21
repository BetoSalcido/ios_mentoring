//
//  RecommendationsCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import Combine
import UIKit

protocol RecommendationsCellViewModelDelegate: AnyObject {
    // Nothing to do yet.
}

class RecommendationsCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var buttonText: String?
    
    private let serviceProvider: ServiceProvider
    private var cellViewModels = [RecommendedCellViewModel]()
    private let tours: [Tour]
    
    let reloadData = Command<Void>()
    
    weak var delegate: ToursCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tours: [Tour]) {
        self.serviceProvider = serviceProvider
        self.tours = tours
        applyBindings()
        generateCellViewModels()
    }
}

// MARK: - Private Methods
private extension RecommendationsCellViewModel {
    
    func applyBindings() {
        titleText = "Recommended"
    }
    
    func generateCellViewModels() {
        cellViewModels = tours.map({
            let cellViewModel = RecommendedCellViewModel(serviceProvider: serviceProvider, tour: $0)
            cellViewModel.delegate = self
            return cellViewModel
        })
        
        reloadData.send()
    }
}

// MaRK: - Public Methods
extension RecommendationsCellViewModel {
    
    var totalCellViewModels: Int {
        return cellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> RecommendedCellViewModel? {
        let indexRow = indexPath.row
        guard cellViewModels.indices.contains(indexRow) else {
            return nil
        }
        
        return cellViewModels[indexRow]
    }
}

// MARK: - RecommendedCellViewModelDelegate
extension RecommendationsCellViewModel: RecommendedCellViewModelDelegate {
    // Nothing to do yet.
}

// MARK: - CellViewModel
extension RecommendationsCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "RecommendationsCell"
    }
}

