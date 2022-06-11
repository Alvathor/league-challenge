//
//  PostService.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

public struct PostService: PostServiceProtocol {
    public let authService: AuthenticationServiceProtocol
    
    public init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    public func getPosts(from user: User) -> AnyPublisher<[Post], Error> {
        let url = URL(string: "\(postAPI)?userId=\(user.id)")!
        
        return Deferred {
            Future { promise in
                self.authService.networkService
                    .get(url: url, callback: promise)
            }
        }
        .eraseToAnyPublisher()
    }
}
