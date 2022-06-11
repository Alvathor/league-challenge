//
//  File.swift
//  
//
//  Created by Marcelo Reis on 09/06/22.
//

import Foundation
import SwiftUI
import Combine

let avatar = User.Avatar(
    large: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
    medium: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
    thumbnail: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png")
)

var posts: [Int: Post] = [
    1: Post(
        id: 1,
        userId: 1,
        user: User(id: 1, avatar: avatar, username: "Clementine Bauche"),
        title: "a quo dolor cumque",
        description: "alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi "
    ),
    2: Post(
        id: 2,
        userId: 2,
        user: User(id: 2, avatar: avatar, username: "Clementine Bauche"),
        title: "a quo dolor cumque",
        description: "alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi "
    ),
    3: Post(
        id: 3,
        userId: 3,
        user: User(id: 3, avatar: avatar, username: "Clementine Bauche"),
        title: "a quo dolor cumque",
        description: "alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi "
    ),
    4: Post(
        id: 4,
        userId: 4,
        user: User(id: 4, avatar: avatar, username: "Clementine Bauche"),
        title: "a quo dolor cumque",
        description: "alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi alias dolor cume impedit blandi "
    )
]

var users = [
    User(id: 1, avatar: avatar, username: "Clementine Bauche"),
    User(id: 2, avatar: avatar, username: "Mary Jane"),
    User(id: 3, avatar: avatar, username: "Lois Lane"),
    User(id: 4, avatar: avatar, username: "Clack Kent"),
]

class MockedPostService: PostServiceProtocol {
    func getPosts(from user: User) -> AnyPublisher<[Post], Error> {
        return Just(
            posts
                .filter {$0.value.userId == user.id }
                .map { $0.value.append(user: user) }
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

class MockedUserService: UserServiceProtocol {
    func getUsers() -> AnyPublisher<[User], Error> {
        return Just(users)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

public struct MockedView: View {
    public var body: some View {
        return NavigationView {
            PostView(postService: MockedPostService(), userService: MockedUserService())
        }
    }
}
