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
    @Published private(set) var title: String?
    
    weak var delegate: TourCellViewModelDelegate?
    
    init() {
        applyBindings()
    }
}

// MARK: - Private Methods
private extension TourCellViewModel {
    
    func applyBindings() {
        // Nothing to do yet.
    }
}

// MARK: - CellViewModel
extension TourCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "TourCell"
    }
}
