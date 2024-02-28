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
    @Published private(set) var descriptionText: String?
    @Published private(set) var descriptionNumberOfLines: Int?
    @Published private(set) var isReadMoreButtonTapped: Bool = false
    
    weak var delegate: TourDetailViewModelDelegate?
    
    init() {
        self.applyBindings()
    }
}

// MARK: Private Methods
private extension TourDetailViewModel {
    
    func applyBindings() {
        descriptionText = "Aspen is a picturesque mountain town nestled in the heart of the Rocky Mountains in Colorado, USA. Renowned for its stunning natural beauty, Aspen is surrounded by towering peaks, lush forests, and pristine alpine lakes, making it a popular destination for outdoor enthusiasts year-round. In the winter, Aspen transforms into a world-class ski resort, attracting skiers and snowboarders from around the globe to its four legendary mountains: Aspen Mountain, Aspen Highlands, Snowmass, and Buttermilk. With hundreds of trails catering to all skill levels, as well as expertly groomed slopes and abundant powder, Aspen offers an unparalleled skiing experience. Beyond its winter sports offerings, Aspen is a vibrant cultural hub with a rich history dating back to its mining days in the late 19th century. The town is home to a thriving arts scene, boasting numerous galleries, theaters, and music venues. Visitors can explore the charming streets lined with Victorian-era buildings, browse upscale boutiques and art galleries, or dine at world-class restaurants offering a diverse array of cuisines. During the summer months, Aspen comes alive with outdoor activities such as hiking, mountain biking, fishing, and white-water rafting. The surrounding wilderness areas offer endless opportunities for exploration and adventure, with scenic trails winding through pristine forests and meadows, and crystal-clear streams teeming with trout. In addition to its natural beauty and outdoor recreation, Aspen hosts a variety of cultural events and festivals throughout the year, including the Aspen Music Festival, the Aspen Ideas Festival, and the renowned Aspen Film Festival. Whether you're seeking adrenaline-pumping adventure, cultural enrichment, or simply a peaceful retreat in nature, Aspen offers something for everyone, making it a truly unforgettable destination."
        descriptionNumberOfLines = 4
    }
}

// MARK: Handler Methods
extension TourDetailViewModel {
    
    func handleReadMoreSelection() {
        isReadMoreButtonTapped = !isReadMoreButtonTapped
        descriptionNumberOfLines = isReadMoreButtonTapped ? 200 : 4
    }
}
