//
//  AuthenticationService.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class AuthenticationService: AuthenticationServiceProtocol {
    public var networkService = CallbackNetworkService()
    
    public func authentication() -> AnyPublisher<Authentication, Error> {
        let url = URL(string: loginAPI)!

        return Deferred {
            Future { promise in
                self.networkService
                    .get(url: url, callback: promise)
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func register(auth: Authentication) {
        networkService.token = auth.apiKey
    }
}
