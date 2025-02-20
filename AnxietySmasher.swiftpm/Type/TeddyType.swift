//
//  File.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

enum TeddyType: CaseIterable {
    
    case teddy1, teddy2, teddy3
    
    var images: [Image] {
        switch self {
        case .teddy1:
            return [Image("teddy1-a"), Image("teddy1-b")]
        case .teddy2:
            return [Image("teddy2-a"), Image("teddy2-b")]
        case .teddy3:
            return [Image("teddy3-a"), Image("teddy3-b")]
        }
    }
    
}
