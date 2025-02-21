//
//  TeddyType.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/18/25.
//

import SwiftUI

enum TeddyType: CaseIterable {
    
    case teddy1, teddy2, teddy3, teddy4, teddy5, teddy6, teddy7, teddy8
    
    var images: [Image] {
        switch self {
        case .teddy1:
            return [Image("Teddy1-a"), Image("Teddy1-b")]
        case .teddy2:
            return [Image("Teddy2-a"), Image("Teddy2-b")]
        case .teddy3:
            return [Image("Teddy3-a"), Image("Teddy3-b")]
        case .teddy4:
            return [Image("Teddy4-a"), Image("Teddy4-b")]
        case .teddy5:
            return [Image("Teddy5-a"), Image("Teddy5-b")]
        case .teddy6:
            return [Image("Teddy6-a"), Image("Teddy6-b")]
        case .teddy7:
            return [Image("Teddy7-a"), Image("Teddy7-b")]
        case .teddy8:
            return [Image("Teddy8-a"), Image("Teddy8-b")]
        }
    }
}

