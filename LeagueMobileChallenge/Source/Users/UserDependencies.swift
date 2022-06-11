//
//  UserDependencies.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine

public protocol UserServiceProtocol: Service {
    func getUsers() -> AnyPublisher<[User], Error>
}

