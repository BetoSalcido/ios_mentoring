//
//  AlersService.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import Foundation
import UIKit

struct Alert {
    
    struct Action {
        let title: String
        let style: UIAlertAction.Style
        let handler: (() -> Void)?
        
        init(title: String,
             style: UIAlertAction.Style,
             handler: (() -> Void)? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }

    let titleKey: String
    let messageKey: String
    let acceptAction: Action
    let cancelAction: Action?
    
    init(titleKey: String,
         messageKey: String,
         acceptAction: Action,
         cancelAction: Action?) {
        self.titleKey = titleKey
        self.messageKey = messageKey
        self.acceptAction = acceptAction
        self.cancelAction = cancelAction
    }
}

class AlertsService {
    
    func runAlert(on viewController: UIViewController, alert: Alert) {
        let alertController = UIAlertController(title: alert.titleKey, message: alert.messageKey, preferredStyle: .alert)
        
        /// Configure `Cancel` button, if present.
        if let cancelAction = alert.cancelAction {
            let cancelButtonTitle = cancelAction.title
            let cancelHandler: (UIAlertAction) -> Void = { _ in cancelAction.handler?()}
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: cancelAction.style, handler: cancelHandler)
            
            alertController.addAction(cancelButton)
        }
        
        let acceptButtonTitle = alert.acceptAction.title
        let acceptHandler: (UIAlertAction) -> Void = { _ in alert.acceptAction.handler?()}
        let acceptButton = UIAlertAction(title: acceptButtonTitle, style: alert.acceptAction.style, handler: acceptHandler)
        
        alertController.addAction(acceptButton)
        
        viewController.present(alertController, animated: true)
        
    }
}
