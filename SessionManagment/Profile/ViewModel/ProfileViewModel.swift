//
//  ProfileViewModel.swift
//  SessionManagment
//
//  Created by Beto Salcido on 29/04/24.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func viewModelDidRequestLogout(_ viewModel: ProfileViewModel)
}

class ProfileViewModel {
    
    /// Bindings
    @Published private(set) var isLogged: Bool = false
    @Published private(set) var email: String?
    
    private let serviceProvider : ServiceProvider
    weak var delegate: ProfileViewModelDelegate?
    
    init(serviceProvider: ServiceProvider) {
        self.serviceProvider = serviceProvider
        self.applyBindings()
    }
}

// MARK: Private Methods
private extension ProfileViewModel {
    
    func applyBindings() {
        isLogged = UserDefaults.standard.bool(forKey: "isLogged")
        email = UserDefaults.standard.string(forKey: "userEmail")
    }
}

// MARK: Handler Methods
extension ProfileViewModel {
    
    func handleSwitchState(_ isOn: Bool) {
        isLogged = isOn
        UserDefaults.standard.set(false, forKey: "isLogged")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        delegate?.viewModelDidRequestLogout(self)
    }
}
