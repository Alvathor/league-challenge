//
//  UserService.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

public struct UserService: UserServiceProtocol {
    public let authService: AuthenticationServiceProtocol
    
    public init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    public func getUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: userAPI)!
        
        return Deferred {
            Future { promise in
                self.authService.networkService
                    .get(url: url, callback: promise)
            }
        }
        .eraseToAnyPublisher()
    }
}
