//
//  User.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

fileprivate struct RawServerResponse: Decodable {
    public let id: Int
    public let avatar: Avatar
    public let username: String
    
    public struct Avatar: Decodable {
        var large: String
        var medium: String
        var thumbnail: String
    }
}

public struct User: Identifiable, Codable {
    public let id: Int
    public let avatar: Avatar?
    public let username: String
    
    public struct Avatar: Decodable {
        var large: URL?
        var medium: URL?
        var thumbnail: URL?
    }
    
    enum CodingKeys: String, CodingKey {
        case id, avatar, username
    }
    
    // It's was needed create this constructor to mock the service in Composition Root
    public init(
        id: Int,
        avatar: Avatar?,
        username: String
    ) {
        self.id = id
        self.avatar = avatar
        self.username = username
    }
    
    public init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
        id = rawResponse.id
        
        let avatar = Avatar(
            large: URL(string: rawResponse.avatar.large),
            medium: URL(string: rawResponse.avatar.medium),
            thumbnail: URL(string: rawResponse.avatar.thumbnail)
        )
        self.avatar = avatar
        
        username = rawResponse.username
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
    }
}
