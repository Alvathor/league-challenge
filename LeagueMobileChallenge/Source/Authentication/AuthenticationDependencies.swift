//
//  AuthenticationDependencies.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine

public protocol AuthenticationServiceProtocol: Service {
    var networkService: CallbackNetworkService { get set }
    
    func authentication() -> AnyPublisher<Authentication, Error>
    func register(auth: Authentication)
}
