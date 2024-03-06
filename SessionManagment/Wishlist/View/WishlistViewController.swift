//
//  WishlistViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 06/03/24.
//

import Foundation
import UIKit

class WishlistViewController: UIViewController {
    
    private var bindings = Bindings()
    
    var viewModel: WishlistViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Wishlist"
        
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureBindings()
    }
}

// MARK: - Private Methods
private extension WishlistViewController {
    
    func configureBindings() {
        
    }
}

// MARK: - StoryboardInitializable
extension WishlistViewController: StoryboardInitializable {
    static let storyboardName = "Wishlist"
}
