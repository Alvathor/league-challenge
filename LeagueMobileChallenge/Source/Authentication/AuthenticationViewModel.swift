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
        
        public func authentication() {
            authService
                .authentication()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished: print("[AUTH]:finished")
                    case .failure(let error):
                        print("[AUTH]:", error)
                        self?.state = .failure(error)
                    }
                }, receiveValue: { [weak self] auth in
                    self?.register(auth: auth)
                })
                .store(in: &cancellables)
        }
        
        private func register(auth: Authentication) {
            state = .loggedIn
            authService.register(auth: auth)
        }
    }
}
