//
//  NetworkingService+TourRouter.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

extension NetworkingService {
    
    enum TourRouter: URLRequestConvertible {
        case fetchTours
        case fetchTourDetails(tourId: String)
        
        var endpoint: String {
            switch self {
            case .fetchTours:
                return "/tours"
            case .fetchTourDetails(let tourId):
                return "/events/\(tourId)"
            }
        }
        
        var method: String {
            switch self {
            case .fetchTours:
                return "GET"
            case .fetchTourDetails:
                return "GET"
            }
        }
        
        func makeURLRequest() throws -> URLRequest {
            guard let url = URL(string: NetworkingService.APIConfig.baseURL + endpoint) else {
                throw NetworkingService.NetworkError.invalidURL
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            
            return request
        }
    }
}
