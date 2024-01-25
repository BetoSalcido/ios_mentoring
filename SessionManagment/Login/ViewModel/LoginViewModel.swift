//
//  LoginViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: LoginViewModel, didRequestAlertWith alert: Alert)
}

class LoginViewModel {
    
    /// Bindings
    @Published private(set) var isPerformLoginButtonEnabled: Bool = false
    
    private lazy var networkingService = serviceProvider.networkingService
    private(set) lazy var alertService = serviceProvider.alertsService
    private let serviceProvider: ServiceProvider
    
    weak var delegate: LoginViewModelDelegate?
    
    private var username = ""
    private var password = ""
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
        performLogin()
    }
}

// MARK: - Private Methods
private extension LoginViewModel {
    
    func performLogin() {
        let credentials = Credentials(user: "ls0523", password: "12345")
        networkingService.performLogin(with: credentials) { result in
            if result {
                print("El inicio sesión fue exitoso")
            } else {
                print("Error en las credenciales.")
            }
        }
    }
    
    func validateForm() {
        isPerformLoginButtonEnabled = username.count > 5 && password.count > 5
    }
}

// MARK: - Handler Methods
extension LoginViewModel {
    
    func handleDidEditUsernameField(_ text: String) {
        username = text
        validateForm()
    }
    
    func handleDidEditPasswordField(_ text: String) {
        password = text
        validateForm()
    }
    
    func handlePerformButtonSelection() {
        if isPerformLoginButtonEnabled {
            let acceptAction = Alert.Action(title: "Aceptar", style: .default)
            let alert = Alert(titleKey: "Lo Sentimos", messageKey: "Los datos ingresados no son correctos.", acceptAction: acceptAction, cancelAction: nil)
            delegate?.viewModel(self, didRequestAlertWith: alert)
        }
    }
}
