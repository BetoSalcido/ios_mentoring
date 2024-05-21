//
//  NetworkRepository+Protocol.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

protocol NetworkRepositoryProtocol {
    func fetchTours() async throws -> [NetworkingService.Tour]
    func fetchTourDetails(tourId: String) async throws -> NetworkingService.Tour
}
