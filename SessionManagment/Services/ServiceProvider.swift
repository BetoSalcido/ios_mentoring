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
    
    /// Manages the Login HTTP request
    var networkService: NetworkService { get }
    
    /// Manages the All the HTTP request
    var networkRepository: NetworkRepository { get}
    
    /// Manages the userDefaults values
    var userDefaultsService: UserDefaultsService { get}
}

class AppServiceProvider: ServiceProvider {
    
    lazy var alertsService: AlertsService = {
        return AlertsService()
    }()
    
    lazy var networkService: NetworkService = {
        return NetworkService()
    }()
    
    lazy var userDefaultsService: UserDefaultsService = {
        return UserDefaultsService()
    }()
    
    var networkRepository: NetworkRepository {
        return NetworkRepository(networkingService: NetworkingService.APIClient())
    }
}
