//
//  CategoryCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation
import Combine
import UIKit

protocol CategoryCellViewModelDelegate: AnyObject {
    // Nothing to do yet.
}

class CategoryCellViewModel {
    
    /// Binding
    @Published private(set) var title: String?
    @Published private(set) var isSelected: Bool = false
    
    private let serviceProvider: ServiceProvider
    private let category: Category
    
    weak var delegate: CategoryCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         category: Category) {
        self.serviceProvider = serviceProvider
        self.category = category
        applyBindings()
    }
}

// MARK: - Private Methods
private extension CategoryCellViewModel {
    
    func applyBindings() {
        title = category.title
    }
}

// MARK: - Handler Methods
extension CategoryCellViewModel {
    
    func handleCellSelection(with state: Bool) {
        isSelected = state
    }
    
}
// MARK: - CellViewModel
extension CategoryCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "CategoryCell"
    }
}
