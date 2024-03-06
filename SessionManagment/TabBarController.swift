//
//  TabBarController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 07/02/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private let serviceProvider: ServiceProvider
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureTabBar()
        configureViewControllers()
    }
}

// MARK: - Private Methods
private extension TabBarController {
    
    func configureTabBar() {
        tabBar.tintColor = UIColor(red: 0.09, green: 0.44, blue: 0.95, alpha: 1.00)
        tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    func configureViewControllers() {
        viewControllers = [
            createTabBarController(with: makeHomeViewController(), image: UIImage(named: "Home")!),
            createTabBarController(with: makeWishlistViewController(), image: UIImage(named: "Heart")!),
            createTabBarController(with: makeProfileViewController(), image: UIImage(named: "Profile")!)
        ]
    }
    
    func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel(serviceProvider: serviceProvider)
        let viewController = HomeViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func makeWishlistViewController() -> UIViewController {
        let viewModel = WishlistViewModel(serviceProvider: serviceProvider)
        let viewController = WishlistViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func makeProfileViewController() -> UIViewController {
        let viewModel = HomeViewModel(serviceProvider: serviceProvider)
        let viewController = HomeViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createTabBarController(with rootViewController: UIViewController,
                                image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = .white
        navigationController.tabBarItem.image = image
        // NOTE: This is the code to add title to the tabBarItem
        // navigationController.tabBarItem.title = ""
        navigationController.navigationBar.barStyle = .default
        return navigationController
    }
}
