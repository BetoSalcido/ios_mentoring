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
    func viewModel(_ viewModel: TourCellViewModel, didSelectTour tour: Tour)
}

class TourCellViewModel {
    
    /// Binding
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    @Published private(set) var isFavoriteButtonSelected: Bool = false
    
    private let serviceProvider: ServiceProvider
    private let tour: Tour
    weak var delegate: TourCellViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        applyBindings()
    }
}

// MARK: - Private Methods
private extension TourCellViewModel {
    
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
extension TourCellViewModel {
    
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
    }
}

// MARK: - CellViewModel
extension TourCellViewModel: CellViewModel {
    var cellIdentifier: String {
        return "TourCell"
    }
}
