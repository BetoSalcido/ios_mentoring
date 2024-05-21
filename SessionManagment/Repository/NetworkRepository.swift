//
//  NetworkRepository.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

class NetworkRepository: NetworkRepositoryProtocol {

    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func fetchTours() async throws -> [NetworkingService.Tour] {
        return try await networkingService.fetchTours()
    }
    
    func fetchTourDetails(tourId: String) async throws -> NetworkingService.Tour {
        return try await networkingService.fetchTourDetails(tourId: tourId)
    }

}
