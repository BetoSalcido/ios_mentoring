//
//  LoginViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private var performLoginButton: UIButton!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    
    private var bindings = Bindings()
    var viewModel: LoginViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Validation to make sure that the viewModel is added to the viewController.
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureBindings()
    }
}

// MARK: - Private Methods
private extension LoginViewController {
    
    func configureBindings() {
        viewModel.$isPerformLoginButtonEnabled
            .assign(to: \.isEnabled, on: performLoginButton)
            .store(in: &bindings)
    }
}

// MARK: - Action Methods
private extension LoginViewController {
    
    @IBAction func didTapPerformButton(_ sender: Any) {
//        UserDefaults.standard.set(true, forKey: "isLogged")
//        sceneDelegate.validateUserSession()
        viewModel.handlePerformButtonSelection()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func didTapPerformLoginButtun(_ sender: Any) {
        
    }
    
    /// Método para detectar los cambios en los textFields
    @IBAction func didEditTextField(_ sender: UITextField) {
        switch sender {
        case usernameTextField:
            viewModel.handleDidEditUsernameField(sender.text ?? "")
        case passwordTextField:
            viewModel.handleDidEditPasswordField(sender.text ?? "")
        default:
            assertionFailure("Unexpected text field")
            break
        }
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    
    func viewModel(_ viewModel: LoginViewModel, didRequestAlertWith alert: Alert) {
        self.viewModel.alertService.runAlert(on: self, alert: alert)
    }
}


// MARK: - StoryboardInitializable
extension LoginViewController: StoryboardInitializable {
    static let storyboardName = "Login"
}





