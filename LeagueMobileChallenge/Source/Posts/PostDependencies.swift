//
//  PostDependencies.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine

public protocol PostServiceProtocol: Service {
    func getPosts(from user: User) -> AnyPublisher<[Post], Error>
}

