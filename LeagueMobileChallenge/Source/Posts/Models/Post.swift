//
//  Post.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

public struct Post: Identifiable, Codable {
    public let id: Int
    let userId: Int
    var user: User?
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, userId, user, title
        case description = "body"
    }
    
    // It's was needed create this constructor to mock the service in Composition Root
    public init(
        id: Int,
        userId: Int,
        user: User?,
        title: String,
        description: String
    ) {
        self.id = id
        self.userId = userId
        self.user = user
        self.title = title
        self.description = description
    }
    
    public func append(user: User) -> Post {
        Post(
            id: id,
            userId: user.id,
            user: user,
            title: title,
            description: description
        )
    }
}
