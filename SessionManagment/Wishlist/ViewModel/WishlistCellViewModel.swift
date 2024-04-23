//
//  WishlistCellViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 23/04/24.
//

import Foundation
import Combine
import UIKit

protocol WishlistCellViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: WishlistCellViewModel, didSelectTour tour: Tour)
    func viewModelDidRequestReload(_ viewModel: WishlistCellViewModel)
}

class WishlistCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    @Published private(set) var isFavoriteButtonSelected: Bool = false
    
    private let serviceProvider: ServiceProvider
    private let tour: Tour
    weak var delegate: WishlistCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
    }
}

// MARK: - Private Methods
private extension WishlistCellViewModel {
    
    func applyBindings() {
        titleText = tour.name
        reviewText = "\(tour.stars)"
        validateFavorite()
    }
    
    func validateFavorite() {
        if let data = UserDefaults.standard.value(forKey: "favoritesArray") as? Data {
            let favoriteArray: [Tour] = try! PropertyListDecoder().decode([Tour].self, from: data)
            
            isFavoriteButtonSelected = favoriteArray.contains(where: { element in
                element.id == tour.id
            })
        }
    }
}

// MARK: - Handler Methods
extension WishlistCellViewModel {
    
    func handleSelection() {
        delegate?.viewModel(self, didSelectTour: tour)
    }
    
    func handleFavoriteSelection() {
        isFavoriteButtonSelected = !isFavoriteButtonSelected
        
        if let data = UserDefaults.standard.value(forKey: "favoritesArray") as? Data {
            var favoriteArray: [Tour] = try! PropertyListDecoder().decode([Tour].self, from: data)
        
            if favoriteArray.isEmpty && isFavoriteButtonSelected {
                UserDefaults.standard.setValue(try? PropertyListEncoder().encode([tour]), forKey: "favoritesArray")
                
            } else {
                
                if isFavoriteButtonSelected {
                    let newArray = favoriteArray.filter {
                        $0.id == tour.id
                    }
                    
                    if newArray.isEmpty {
                        favoriteArray.append(tour)
                        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(favoriteArray), forKey: "favoritesArray")
                    }
                    
                } else {
                    let newArray = favoriteArray.filter {
                        $0.id != tour.id
                    }
            
                    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newArray), forKey: "favoritesArray")
                }
            }
        } else {
            // If the array is nil and the button favorite selected, we must add the element.
            if isFavoriteButtonSelected {
                UserDefaults.standard.setValue(try? PropertyListEncoder().encode([tour]), forKey: "favoritesArray")
            }
        }
        
        delegate?.viewModelDidRequestReload(self)
        
    }
}

// MARK: - CellViewModel
extension WishlistCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "WishlistCell"
    }
}
