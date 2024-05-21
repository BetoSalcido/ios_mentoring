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
    func viewModel(_ viewModel: ToursCellViewModel, didSelectTour tour: NetworkingService.Tour)
}

class ToursCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var buttonText: String?
    
    private let serviceProvider: ServiceProvider
    private var cellViewModels = [TourCellViewModel]()
    private let tours: [NetworkingService.Tour]
    
    let reloadData = Command<Void>()
    
    weak var delegate: ToursCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tours: [NetworkingService.Tour],
         titleText: String,
         buttonText: String) {
        self.serviceProvider = serviceProvider
        self.tours = tours
        self.titleText = titleText
        self.buttonText = buttonText
        generateCellViewModels()
    }
}

// MARK: - Private Methods
private extension ToursCellViewModel {
    
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
    
    func viewModel(_ viewModel: TourCellViewModel, didSelectTour tour: NetworkingService.Tour) {
        delegate?.viewModel(self, didSelectTour: tour)
    }
}

// MARK: - CellViewModel
extension ToursCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "ToursCell"
    }
}
