//
//  NetworkingService+APIClient.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

extension NetworkingService {
    
    class APIClient: BaseAPIClient<TourRouter>, NetworkingServiceProtocol {
        func fetchTours() async throws -> [NetworkingService.Tour] {
            return try await request([Tour].self, router: .fetchTours)
        }
        
        func fetchTourDetails(tourId: String) async throws -> NetworkingService.Tour {
            return try await request(Tour.self, router: .fetchTourDetails(tourId: tourId))
        }
    }
}
