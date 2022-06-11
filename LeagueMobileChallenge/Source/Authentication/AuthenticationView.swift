//
//  AuthenticationView.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

public struct AuthenticationView: View {
    @StateObject var viewModel: ViewModel
    
    public init(authService: AuthenticationServiceProtocol) {
        self._viewModel = StateObject(
            wrappedValue: ViewModel(authService: authService)
        )
    }
    
    public var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                Text("Authenticating...")
            case .loggedIn:
                PostView(
                    postService: PostService(authService: viewModel.authService),
                    userService: UserService(authService: viewModel.authService)
                )
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
            }
        }
        .onAppear{  Task { try await viewModel.authentication() } }
    }
}
