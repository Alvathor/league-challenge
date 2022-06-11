//
//  ServiceDependencies.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public protocol Service {
    var domain: String { get }
    var loginAPI: String { get }
    var postAPI: String { get }
    var userAPI: String { get }
}

extension Service {
    public var domain: String {
        return "https://engineering.league.dev/challenge/api/"
    }
    
    public var loginAPI: String {
        return domain + "login"
    }
    
    public var postAPI: String {
        return domain + "posts"
    }
    
    public var userAPI: String {
        return domain + "users"
    }
}
