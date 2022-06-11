//
//  AuthenticationViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 11/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Combine
import SwiftUI
import Foundation

public enum AuthState {
    case loading
    case loggedIn
    case failure(Error)
}

extension AuthenticationView {
    class ViewModel: ObservableObject {
        @Published var state: AuthState = .loading
        public let authService: AuthenticationServiceProtocol
        private var cancellables: Set<AnyCancellable> = []
        
        init(authService: AuthenticationServiceProtocol) {
            self.authService = authService
        }
        
        public func authentication() async throws {
            do {
                let auth = try await authService.authentication().async()
                await MainActor.run {
                    register(auth: auth)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        private func register(auth: Authentication) {
            state = .loggedIn
            authService.register(auth: auth)
        }
    }
}
