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
    @Published private(set) var titleText: String?
    @Published private(set) var reviewText: String?
    @Published private(set) var priceText: String?
    @Published private(set) var imageURL: URL?
    @Published private(set) var descriptionText: String?
    @Published private(set) var descriptionNumberOfLines: Int?
    @Published private(set) var isReadMoreButtonTapped: Bool = false
    @Published private(set) var isFavoriteButtonSelected: Bool = false
    
    private let serviceProvider: ServiceProvider
    private lazy var userDefaultsService = serviceProvider.userDefaultsService
    private let tour: NetworkingService.Tour
    weak var delegate: TourDetailViewModelDelegate?
    
    init(serviceProvider: ServiceProvider,
         tour: NetworkingService.Tour) {
        self.serviceProvider = serviceProvider
        self.tour = tour
        self.applyBindings()
    }
}

// MARK: Private Methods
private extension TourDetailViewModel {
    
    func applyBindings() {
        titleText = tour.name
        reviewText = "\(tour.rating)"
        priceText = "$\(tour.price)"
        imageURL = URL(string: tour.imageURL)
        descriptionText = tour.description
        descriptionNumberOfLines = 4
        validateFavorite()
        
    }
    
    func validateFavorite() {
        isFavoriteButtonSelected = userDefaultsService.validateTour(tour: tour)
    }
}

// MARK: Handler Methods
extension TourDetailViewModel {
    
    func handleReadMoreSelection() {
        isReadMoreButtonTapped = !isReadMoreButtonTapped
        descriptionNumberOfLines = isReadMoreButtonTapped ? 200 : 4
    }
    
    func handlerFavoriteButtonSelection() {
        isFavoriteButtonSelected = !isFavoriteButtonSelected

        if let data = UserDefaults.standard.value(forKey: "favoritesArray") as? Data {
            var favoriteArray: [NetworkingService.Tour] = try! PropertyListDecoder().decode([NetworkingService.Tour].self, from: data)
        
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
