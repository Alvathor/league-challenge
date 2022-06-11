//
//  File.swift
//  
//
//  Created by Marcelo Reis on 10/06/22.
//

import SwiftUI

public extension Font {
    static func headingMedium() -> Font {
        Font.system(size: 17).weight(.medium)
    }
    static func bodyRegular() -> Font {
        Font.system(size: 15)
    }
}
