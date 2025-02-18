//
//  File.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

enum TabAccentColorType: CaseIterable {
    case purple, yellow, cyan
    
    var color: Color {
        switch self {
        case .purple:
            Color.yrPurpleDark
        case .yellow:
            Color.yrYellowDark
        case .cyan:
            Color.yrCyanDark
        }
    }
}
