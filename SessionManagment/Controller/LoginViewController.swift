//
//  LoginViewController.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapPerformButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLogged")
        sceneDelegate.validateUserSession()
    }
}
