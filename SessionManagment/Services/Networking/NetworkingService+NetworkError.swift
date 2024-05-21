//
//  NetworkingService+NetworkError.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

extension NetworkingService {
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(statusCode: Int)
        case invalidResponse
        case dataConversionFailure
    }
}
