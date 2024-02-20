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
    @Published private(set) var titleText: String?
    @Published private(set) var buttonText: String?
    
    private let serviceProvider: ServiceProvider
    private var cellViewModels = [TourCellViewModel]()
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
private extension ToursCellViewModel {
    
    func applyBindings() {
        titleText = "Popular"
        buttonText = "See All"
    }
    
    func generateCellViewModels() {
        cellViewModels = tours.map({
            let cellViewModel = TourCellViewModel(serviceProvider: serviceProvider, tour: $0)
            cellViewModel.delegate = self
            return cellViewModel
        })
        
        reloadData.send()
    }
}

// MaRK: - Public Methods
extension ToursCellViewModel {
    
    var totalCellViewModels: Int {
        return cellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> TourCellViewModel? {
        let indexRow = indexPath.row
        guard cellViewModels.indices.contains(indexRow) else {
            return nil
        }
        
        return cellViewModels[indexRow]
    }
}

// MARK: - TourCellViewModelDelegate
extension ToursCellViewModel: TourCellViewModelDelegate {
    // Nothing to do yet.
}

// MARK: - CellViewModel
extension ToursCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "ToursCell"
    }
}
