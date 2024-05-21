//
//  NetworkingService+BaseAPIClient.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

extension NetworkingService {
    
    class BaseAPIClient<Router: URLRequestConvertible> {
        private let urlSession: URLSession
        
        init(urlSession: URLSession = URLSession.shared) {
            self.urlSession = urlSession
        }

        private func handleResponse(data: Data, response: URLResponse) throws {
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingService.NetworkError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingService.NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
        }
        
        /// Performs an asynchronous network request and decodes the response data
        /// into the specified type.
        ///
        /// - Parameters:
        ///   - router: An object conforming to the `URLRequestConvertible` protocol.
        ///   - returnType: The type into which the response data should be decoded.
        ///
        /// - Throws:
        ///   - `NetworkError.dataConversionFailure` if data cannot be decoded into the specified type.
        ///
        /// - Returns:
        ///   The decoded data of the specified type.
        func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
            let request = try router.makeURLRequest()
            
            guard let url = request.url else {
                throw NetworkingService.NetworkError.invalidURL
            }
            
            let (data, response) = try await urlSession.data(from: url)
            
            try handleResponse(data: data, response: response)
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(returnType, from: data)
                return decodedData
            } catch {
                throw NetworkingService.NetworkError.dataConversionFailure
            }
        }
    }
}
