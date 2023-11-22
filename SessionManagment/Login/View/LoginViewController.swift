//
//  LoginViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Validation to make sure that the viewModel is added to the viewController.
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
    }
    
    @IBAction func didTapPerformButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLogged")
        sceneDelegate.validateUserSession()
    }
}

// MARK: - StoryboardInitializable
extension LoginViewController: StoryboardInitializable {
    static let storyboardName = "Login"
}
