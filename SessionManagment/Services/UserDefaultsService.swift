//
//  UserDefaultsService.swift
//  SessionManagment
//
//  Created by Beto Salcido on 06/06/24.
//

import Foundation

class UserDefaultsService {
    
    private lazy var userDefaults = UserDefaults.standard
    
    var dataTours: Data? {
        return userDefaults.value(forKey: Self.favorites) as? Data
    }
    
    var tours: [NetworkingService.Tour] {
        guard let data = dataTours else {
            return []
        }
        
        return try! PropertyListDecoder().decode([NetworkingService.Tour].self, from: data)
    }
    
//    func asdas() {
//        if let data = UserDefaults.standard.value(forKey: "favoritesArray") as? Data {
//            var favoriteArray: [NetworkingService.Tour] = try! PropertyListDecoder().decode([NetworkingService.Tour].self, from: data)
//        
//            if favoriteArray.isEmpty && isFavoriteButtonSelected {
//                UserDefaults.standard.setValue(try? PropertyListEncoder().encode([tour]), forKey: "favoritesArray")
//                
//            } else {
//                
//                if isFavoriteButtonSelected {
//                    let newArray = favoriteArray.filter {
//                        $0.id == tour.id
//                    }
//                    
//                    if newArray.isEmpty {
//                        favoriteArray.append(tour)
//                        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(favoriteArray), forKey: "favoritesArray")
//                    }
//                    
//                } else {
//                    let newArray = favoriteArray.filter {
//                        $0.id != tour.id
//                    }
//            
//                    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newArray), forKey: "favoritesArray")
//                }
//            }
//        } else {
//            // If the array is nil and the button favorite selected, we must add the element.
////            if isFavoriteButtonSelected {
////                UserDefaults.standard.setValue(try? PropertyListEncoder().encode([tour]), forKey: "favoritesArray")
////            }
//        }
//    }
    
    func addTour(tour: NetworkingService.Tour) {
        userDefaults.setValue(try? PropertyListEncoder().encode([tour]), forKey: Self.favorites)
    }
    
    func removeTour(tour: NetworkingService.Tour) {
        
    }
    
    func validateTour(tour: NetworkingService.Tour) -> Bool {
        return tours.contains(where: { element in
            element.id == tour.id
        })
        
    }
}

// MARK: - Constants
private extension UserDefaultsService {
    static let favorites = "favoritesArray"
}
