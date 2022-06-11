//
//  PostViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine
import Dispatch

extension PostView {
    class ViewModel: ObservableObject {
        @Published var posts: [Post]
        private let postService: PostServiceProtocol
        private let userService: UserServiceProtocol
        
        init(
            postService: PostServiceProtocol,
            userService: UserServiceProtocol
        ) {
            self.posts = []
            self.postService = postService
            self.userService = userService
        }

        // Runs in background
        public func loadUsers() async throws {
            let _ = try await userService
                .getUsers()
                .async().concurrentMap { user in
                    let posts = try await self.postService.getPosts(from: user).async()
                    await MainActor.run {
                        self.posts +=  posts.map { $0.append(user: user) }
                    }
                }

        }
    }
}
