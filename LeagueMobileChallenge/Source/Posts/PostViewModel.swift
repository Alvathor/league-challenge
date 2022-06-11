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
        private var cancellables: Set<AnyCancellable> = []
        
        init(
            postService: PostServiceProtocol,
            userService: UserServiceProtocol
        ) {
            self.posts = []
            self.postService = postService
            self.userService = userService
        }
        
        // Runs in main thread
        public func loadPosts(from user: User) async {
            postService
                .getPosts(from: user)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: print("[POSTS]:Finished")
                    case .failure(let error): print("[POSTS]:", error)
                    }
                }, receiveValue: { posts in
                    let postsWithUser = posts.map { $0.append(user: user) }
                    self.posts += postsWithUser
                })
                .store(in: &cancellables)
        }
        
        // Runs in background
        public func loadUsers() {
            userService
                .getUsers()
                .receive(on: DispatchQueue.global(qos: .background))
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished: print("[USERS]:Finished")
                    case .failure(let error): print("[USERS]:", error)
                    }
                }, receiveValue: { users in
                    Task { [weak self] in
                        for user in users {
                            await self?.loadPosts(from: user)
                        }
                    }
                })
                .store(in: &cancellables)
        }
    }
}
