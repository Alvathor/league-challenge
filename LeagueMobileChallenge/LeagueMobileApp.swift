//
//  LeagueMobileApp.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 09/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI

@main
struct LeagueMobileApp: App {
    var body: some Scene {
        WindowGroup {
            AuthenticationView(authService: AuthenticationService())
//            MockedView()
        }
    }
}
