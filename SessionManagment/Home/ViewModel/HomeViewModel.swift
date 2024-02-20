//
//  HomeViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import Foundation
 
protocol HomeViewModelDelegate: AnyObject {
    // Nothing to do
}

class HomeViewModel {
    
    /// A type to represent a section of cells in the list
    struct Section {
        let title: String
        let buttonTitle: String
        var cellViewModel: CellViewModel
        
        init(title: String, 
             buttonTitle: String,
             cellViewModel: CellViewModel) {
            self.title = title
            self.buttonTitle = buttonTitle
            self.cellViewModel = cellViewModel
        }
    }
    
    /// Bindings
    @Published private(set) var title: String?
    
    private let serviceProvider: ServiceProvider
    private var sections = [Section]()
    let reloadData = Command<Void>()
    
    weak var delegate: HomeViewModelDelegate?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
}

// MARK: Private Methods
private extension HomeViewModel {
    
    func generataCellViewModels() {
        
        let categories: [Category] = [
            Category(id: "1", title: "Location"),
            Category(id: "2", title: "Hotels"),
            Category(id: "3", title: "Food"),
            Category(id: "4", title: "Adventure")
        ]
        let categoryCellViewModel = CategoriesCellViewModel(serviceProvider: serviceProvider, categories: categories)
        let categorySection = Section(title: "Filters", buttonTitle: "", cellViewModel: categoryCellViewModel)
        
        let popularCellViewModel = ToursCellViewModel(serviceProvider: serviceProvider, tours: Tour.tours)
        let popularSection = Section(title: "Popular", buttonTitle: "See All", cellViewModel: popularCellViewModel)
        
        sections.append(categorySection)
        sections.append(popularSection)
        reloadData.send()
    }
}

// MARK: Public Methods
extension HomeViewModel {
    
    var totalSections: Int {
        return sections.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CellViewModel? {
        let indexSection = indexPath.section
        guard sections.indices.contains(indexSection) else {
            return nil
        }
        
        return sections[indexSection].cellViewModel
    }
    
    func cellViewModelSize(at indexPath: IndexPath) -> Double {
        let indexSection = indexPath.section
        guard sections.indices.contains(indexSection) else {
            return 0.0
        }
        
        if sections[indexSection].title == "Filters" {
            return 74.0
        } else {
            return 274.0
        }
    }
}

// MARK: Handler Methods
extension HomeViewModel {
    
    func handleViewDidLoad() {
        generataCellViewModels()
    }
}

