//
//  PostView.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI
import Combine

public struct PostView: View {
    @StateObject var viewModel: ViewModel
    
    public init(postService: PostServiceProtocol, userService: UserServiceProtocol) {
        self._viewModel = StateObject(
            wrappedValue: ViewModel(postService: postService, userService: userService)
        )
    }
    
    public var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                PostHeader(user: post.user)
                PostBody(post: post)
            }
        }
        .id(UUID())
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea([.trailing, .bottom, .leading])
        .listStyle(PlainListStyle())
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.loadUsers)
        .navigationTitle("Posts")
    }
}

// MARK: - Elements View

struct PostHeader: View {
    let user: User?
    
    public var body: some View {
        HStack(spacing: 16) {
            if let user = user {
                AvatarView(url: user.avatar?.thumbnail)
                Text(user.username)
                    .font(.headingMedium())
            } else {
                Text("No User Found")
                    .font(.headingMedium())
            }
        }
    }
}

struct PostBody: View {
    let post: Post
    
    public var body: some View {
        Text(post.title)
            .font(.headingMedium())
            .padding([.top, .bottom], 2)
        
        Text(post.description)
            .font(.bodyRegular())
    }
}
