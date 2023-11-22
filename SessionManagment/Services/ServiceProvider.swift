//
//  ServiceProvider.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import Foundation

/// Conforms to this protocol to provide access to different services
protocol ServiceProvider {
    
    /// Manages the alerts views
    var alertsService: AlertsService { get }
}

class AppServiceProvider: ServiceProvider {
    
    lazy var alertsService: AlertsService = {
        return AlertsService()
    }()
}
