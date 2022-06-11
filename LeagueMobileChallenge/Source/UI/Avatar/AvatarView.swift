//
//  AvatarView.swift
//  LeagueMobileChallenge
//
//  Created by Marcelo Reis on 10/06/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import SwiftUI

public struct AvatarView: View {
    private let url: URL?
    private let config: AvatarConfig
    
    public init(url: URL?, config: AvatarConfig = AvatarConfig()) {
        self.url = url
        self.config = config
    }
    
    public var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: config.width, height: config.height, alignment: config.alignment)
        .clipShape(Circle())
    }
}
