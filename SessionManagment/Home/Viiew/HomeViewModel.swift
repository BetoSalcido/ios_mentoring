//
//  HomeViewModel.swift
//  SessionManagment
//

//

import Foundation
 
protocol HomeViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: HomeViewModel, didSelectTour tour: NetworkingService.Tour)
    func viewModelDisplayLoadingView(_ viewModel: HomeViewModel)
    func viewModelRemoveLoadingView(_ viewModel: HomeViewModel)
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
    
    private lazy var userDefaultsService = serviceProvider.userDefaultsService
    private lazy var networkRepository = serviceProvider.networkRepository
    private(set) var serviceProvider: ServiceProvider
    private var tours = [NetworkingService.Tour]()
    private var sections = [Section]()
    let reloadData = Command<Void>()
    
    weak var delegate: HomeViewModelDelegate?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
    }
}

// MARK: Private Methods
private extension HomeViewModel {
    
    func generateCellViewModels(with data: [NetworkingService.Tour]) {
        var tours = [NetworkingService.Tour]()
        var destinations = [NetworkingService.Tour]()
        var restaurants = [NetworkingService.Tour]()
        
        for element in data {
            switch element.type.lowercased() {
            case Self.tour:
                tours.append(element)
            case Self.destination:
                destinations.append(element)
            case Self.restaurant:
                restaurants.append(element)
            default:
                print("An unexpected value was found: \(element.type)")
            }
        }
        
        let categories: [Category] = [
            Category(id: "1", title: "Location"),
            Category(id: "2", title: "Hotels"),
            Category(id: "3", title: "Food"),
            Category(id: "4", title: "Adventure")
        ]
        
        let categoryCellViewModel = CategoriesCellViewModel(serviceProvider: serviceProvider, categories: categories)
        let categorySection = Section(title: "Filters", buttonTitle: "", cellViewModel: categoryCellViewModel)
        
        let destinationCellViewModel = ToursCellViewModel(serviceProvider: serviceProvider, tours: destinations, titleText: "Destinations", buttonText: "")
        destinationCellViewModel.delegate = self
        let destinationSection = Section(title: "", buttonTitle: "", cellViewModel: destinationCellViewModel)
        
        let tourCellViewModel = ToursCellViewModel(serviceProvider: serviceProvider, tours: tours, titleText: "Tours", buttonText: "See All")
        tourCellViewModel.delegate = self
        let tourSection = Section(title: "", buttonTitle: "", cellViewModel: tourCellViewModel)
        
        let restaurantViewModel = RecommendationsCellViewModel(serviceProvider: serviceProvider, tours: restaurants)
        let restaurantSection = Section(title: "Restaurants", buttonTitle: "", cellViewModel: restaurantViewModel)
        
        
        sections.append(categorySection)
        sections.append(destinationSection)
        sections.append(tourSection)
        sections.append(restaurantSection)
        reloadData.send()
    }
    
    func requestTours() async {
        DispatchQueue.main.async {
            self.delegate?.viewModelDisplayLoadingView(self)
        }
        
        do {
            let data = try await networkRepository.fetchTours()
            self.tours = data
            DispatchQueue.main.async {
                self.delegate?.viewModelRemoveLoadingView(self)
                self.generateCellViewModels(with: data)
            }
            
        } catch  {
            DispatchQueue.main.async {
                self.delegate?.viewModelRemoveLoadingView(self)
                print(error.localizedDescription)
            }
        }
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
        } else if sections[indexSection].title == "Recommended" {
            return 204
        } else {
            return 274.0
        }
    }
}

// MARK: - ToursCellViewModelDelegate
extension HomeViewModel: ToursCellViewModelDelegate {
    
    func viewModel(_ viewModel: ToursCellViewModel, didSelectTour tour: NetworkingService.Tour) {
        delegate?.viewModel(self, didSelectTour: tour)
    }
}

// MARK: Handler Methods
extension HomeViewModel {
    
    func handleViewDidLoad() {
        Task {
            await requestTours()
        }
    }
    
    func handleReloadRequest() {
        sections.removeAll()
        generateCellViewModels(with: tours)
    }
}

// MARK: - Constants
private extension HomeViewModel {
    static let tour = "tour"
    static let destination = "destination"
    static let restaurant = "restaurant"
}
