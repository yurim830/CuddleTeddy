//
//  File.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

enum FaceType: CaseIterable {
    
    case faceAngry, faceAww, faceEww, faceHappy, faceLove, faceShocked, faceSmile, faceSmileyCry
    
    var image: Image {
        switch self {
        case .faceAngry:
            return Image("face-angry")
        case .faceAww:
            return Image("face-aww")
        case .faceEww:
            return Image("face-eww")
        case .faceHappy:
            return Image("face-happy")
        case .faceLove:
            return Image("face-love")
        case .faceShocked:
            return Image("face-shocked")
        case .faceSmile:
            return Image("face-smile")
        case .faceSmileyCry:
            return Image("face-smiley-cry")
        }
    }
    
}
