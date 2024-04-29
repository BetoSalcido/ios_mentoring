//
//  NetworkingService.swift
//  SessionManagment
//
//  Created by Beto Salcido on 22/11/23.
//

import Foundation

class NetworkingService {
    
    func performLogin(with credentials: Credentials, completion: @escaping (Bool) -> Void) {
        
        if credentials.email == "ls0523@dexcom.com" && credentials.password == "12345" {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                completion(true)
            }
        
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                completion(false)
            }
        }
    }
}
