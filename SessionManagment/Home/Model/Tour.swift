//
//  Tour.swift
//  SessionManagment
//
//  Created by Beto Salcido on 16/02/24.
//

import Foundation

struct Tour {
    let id: String
    let name: String
    let shortDescription: String
    let description: String
    let stars: Double
    let reviews: Int
    let image: String
}

extension Tour {
    static let tours = [
        Tour(id: "1", name: "Alley Palace", shortDescription: "", description: "", stars: 4.7, reviews: 3350, image: ""),
        Tour(id: "2", name: "Coeurdes Alpes", shortDescription: "", description: "", stars: 46, reviews: 250, image: ""),
        Tour(id: "3", name: "Explore Aspen", shortDescription: "", description: "", stars: 4.4, reviews: 260, image: ""),
        Tour(id: "4", name: "Luxurious Aspen", shortDescription: "", description: "", stars: 4.4, reviews: 190, image: ""),
        Tour(id: "5", name: "Alley Palace", shortDescription: "", description: "", stars: 4.3, reviews: 500, image: ""),
        Tour(id: "6", name: "Coeurdes Alpes", shortDescription: "", description: "", stars: 4.2, reviews: 290, image: ""),
        Tour(id: "7", name: "Explore Aspen", shortDescription: "", description: "", stars: 4.2, reviews: 401, image: ""),
        Tour(id: "8", name: "Coeurdes Alpes", shortDescription: "", description: "", stars: 4.1, reviews: 345, image: ""),
    ]
}
