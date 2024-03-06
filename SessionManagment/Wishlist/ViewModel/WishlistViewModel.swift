//
//  WishlistViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 06/03/24.
//

import Foundation

protocol WishlistViewModelDelegate: AnyObject {
    
}

class WishlistViewModel {
    
    /// Bindings
    @Published private(set) var title: String?
    
    private let serviceProvider: ServiceProvider
    weak var delegate: WishlistViewModelDelegate?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
        self.applyBindings()
    }
}

// MARK: Private Methods
private extension WishlistViewModel {
    
    func applyBindings() {}
}

