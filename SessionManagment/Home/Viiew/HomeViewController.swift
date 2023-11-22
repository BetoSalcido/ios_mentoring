//
//  HomeViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapPerformLogoutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogged")
        sceneDelegate.validateUserSession()
    }
}


// MARK: - StoryboardInitializable
extension HomeViewController: StoryboardInitializable {
    static let storyboardName = "Home"
}
