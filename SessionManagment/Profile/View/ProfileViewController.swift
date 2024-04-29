//
//  ProfileViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 29/04/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var headerStackView: UIStackView!
    @IBOutlet private var profileImage: UIImageView!
    @IBOutlet private var profileNameLabel: UILabel!
    @IBOutlet private var profileEmailLabel: UILabel!
    @IBOutlet private var darkModeSwitch: UISwitch!
    @IBOutlet private var darkModeStackView: UIStackView!
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var userSessionSwitch: UISwitch!
    
    
    private var bindings = Bindings()
    
    var viewModel: ProfileViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        guard viewModel != nil else {
            assertionFailure("`viewModel` is required for \(Self.self) to work.")
            return
        }
        
        configureView()
        configureBindings()
    }
}

// MARK: - Private Methods
private extension ProfileViewController {
    
    func configureView() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
        headerStackView.setCustomSpacing(35, after: profileEmailLabel)
        headerStackView.setCustomSpacing(15, after: darkModeStackView)
        
        userSessionSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
    }
    
    func configureBindings() {
        viewModel.$email
            .assign(to: \.text, on: profileEmailLabel)
            .store(in: &bindings)
        
        viewModel.$isLogged
            .sink { [userSessionSwitch] in
                userSessionSwitch?.setOn($0, animated: true)
            }
            .store(in: &bindings)
    }
}

// MARK: - Actions
private extension ProfileViewController {
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        viewModel.handleSwitchState(sender.isOn)
    }
}

// MARK: - ProfileViewModelDelegate
extension ProfileViewController: ProfileViewModelDelegate {
    
    func viewModelDidRequestLogout(_ viewModel: ProfileViewModel) {
        sceneDelegate.validateUserSession()
    }
}

// MARK: - StoryboardInitializable
extension ProfileViewController: StoryboardInitializable {
    static let storyboardName = "Profile"
}
