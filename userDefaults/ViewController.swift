//
//  ViewController.swift
//  userDefaults
//
//  Created by Beto Salcido on 10/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Forma de mandar llamar los userDefaults
        let userDefaults = UserDefaults.standard
        // Forma de guardar información en los userDefaults
//        userDefaults.set("Probando userDefaults", forKey: "userDefaultTestingKey")
        
        // Forma de obtener información de los userDefaults
//        let message = userDefaults.string(forKey: "userDefaultTestingKey")
//        print(message ?? "No hay información guardada.")
        
        // NOTE: Si la aplicación se elimina, todos los userDefaults serán eliminados y no recuperarán
        
        let isUserLogger = userDefaults.bool(forKey: "isUserLogged")

        if isUserLogger {
            print("Mostrar home screen")
            view.backgroundColor = .blue
        } else {
            print("Mostrar login screen")
            userDefaults.set(true, forKey: "isUserLogged")
            view.backgroundColor = .lightGray
        }
        
        
        // Forma de eliminar los userDefaults   
        userDefaults.removeObject(forKey: "isUserLogged")
    }


}

