//
//  NetworkingService+URLRequestConvertible.swift
//  SessionManagment
//
//  Created by Beto Salcido on 30/04/24.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest() throws -> URLRequest
}
