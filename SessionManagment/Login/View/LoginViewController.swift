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
    
    private lazy var animationViewController = AnimationViewController()
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
    
    func displayAnimation() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            guard let self else { return }
            self.animationViewController.view.alpha = 1.0
        }) { [weak self] _ in
            guard let self else { return }
            addChild(self.animationViewController)
            view.addSubview(self.animationViewController.view)
            self.animationViewController.didMove(toParent: self)
        }
    }
    
    func removeAnimation() {
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            guard let self else { return }
            self.animationViewController.view.alpha = 0.0
        }) { [weak self] _ in
            guard let self else { return }
            self.animationViewController.willMove(toParent: nil)
            self.animationViewController.view.removeFromSuperview()
            self.animationViewController.removeFromParent()
        }
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
    
    func viewModelRemoveLoadingView(_ viewModel: LoginViewModel) {
        removeAnimation()
    }
    
    func viewModelDisplayLoadingView(_ viewModel: LoginViewModel) {
        displayAnimation()
    }
    
    func viewModelSuccessfulSession(_ viewModel: LoginViewModel) {
        sceneDelegate.validateUserSession()
    }
    
    func viewModel(_ viewModel: LoginViewModel, didRequestAlertWith alert: Alert) {
        self.viewModel.alertService.runAlert(on: self, alert: alert)
    }
}


// MARK: - StoryboardInitializable
extension LoginViewController: StoryboardInitializable {
    static let storyboardName = "Login"
}





