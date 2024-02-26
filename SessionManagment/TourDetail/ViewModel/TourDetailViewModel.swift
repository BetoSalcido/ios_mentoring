//
//  TourDetailViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation

protocol TourDetailViewModelDelegate: AnyObject {
    
}

class TourDetailViewModel {
    
    /// Bindings
    @Published private(set) var title: String?
    
    weak var delegate: TourDetailViewModelDelegate?
    
    init() {
        self.applyBindings()
    }
}

// MARK: Private Methods
private extension TourDetailViewModel {
    
    func applyBindings() {}
}

