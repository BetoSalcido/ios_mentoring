//
//  CellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 13/02/24.
//

import Foundation

/// A generic view model type for cells to work with.
protocol CellViewModel: CellIdentifiable {
    
}

/// For cell views to configure various cell view models in a generic way.
protocol CellViewModelConfigurable {
    
    /// Called from `tableView: cellForRotAt:` or  `tableView: cellForItemAtIndexPath:`
    func configure(cellViewModel: CellViewModel)
    
    /// Called from `tableView:willDisplayCell:forItemAtIndexPath:` or `collectionView:willDisplayCell:forItemAtIndexPath:`
    func configureWillDisplayCell(cellViewModel: CellViewModel)
    
}

// MARK: - Default Implementation
extension CellViewModelConfigurable {
    func configure(cellViewModel: CellViewModel) {}
    
    func configureWillDisplayCell(cellViewModel: CellViewModel) {}
}
