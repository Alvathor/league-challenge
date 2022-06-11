//
//  AvatarConfig.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI

public struct AvatarConfig {
    let width: CGFloat
    var height: CGFloat
    var alignment: Alignment

    public init(width: CGFloat = 50,
                height: CGFloat = 50,
                alignment: Alignment = .center
    ) {
        self.width = width
        self.height = height
        self.alignment = alignment
    }
}

