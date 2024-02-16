//
//  CategoriesCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation
import Combine
import UIKit

protocol CategoriesCellViewModelDelegate: AnyObject {
    // Nothing to do yet.
}


class CategoriesCellViewModel {
    
    /// Binding
    @Published private(set) var title: String?
    @Published private(set) var indexPath: IndexPath?
    
    private let serviceProvider: ServiceProvider
    private let categories: [Category]
    private var cellViewModels =  [CategoryCellViewModel]()
    
    let reloadData = Command<Void>()
    
    weak var delegate: CategoriesCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         categories: [Category]) {
        self.serviceProvider = serviceProvider
        self.categories = categories
        self.generateCellViewModels()
    }
}

// MARK: - Private Methods
private extension CategoriesCellViewModel {
    
    func generateCellViewModels() {
        cellViewModels = categories.map({
            let cellViewModel = CategoryCellViewModel(serviceProvider: serviceProvider, category: $0)
            cellViewModel.delegate = self
            return cellViewModel
        })
        
        reloadData.send()
    }
}

// MARK: - Public Methods
extension CategoriesCellViewModel {
    
    var totalCellViewModels: Int {
        return cellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        let indexRow = indexPath.row
        guard cellViewModels.indices.contains(indexRow) else {
            return nil
        }
        
        return cellViewModels[indexRow]
    }
}

// MARK: - CategoryCellViewModelDelegate
extension CategoriesCellViewModel: CategoryCellViewModelDelegate {
    // Nothing to do yet.
}

// MARK: - CellViewModel
extension CategoriesCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "CategoriesCell"
    }
}
