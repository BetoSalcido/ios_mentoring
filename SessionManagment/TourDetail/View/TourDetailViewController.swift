//
//  TourDetailViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 21/02/24.
//

import Foundation
import UIKit

class TourDetailViewController: UIViewController {
    
    private var bindings = Bindings()
    
    var viewModel: TourDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureBindings()
    }
}

// MARK: - Private Methods
private extension TourDetailViewController {
    
    func configureBindings() {
        
    }
}

// MARK: - StoryboardInitializable
extension TourDetailViewController: StoryboardInitializable {
    static let storyboardName = "TourDetail"
}
