//
//  UIViewController+App.swift
//  SessionManagment
//
//  Created by Beto Salcido on 15/11/23.
//

import UIKit

extension UIViewController {
    
    @available(iOS 13.0, *)
    var sceneDelegate: SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    }
}
