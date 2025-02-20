//
//  File.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/21/25.
//

import SwiftUI

struct HeartBubbleModel: Identifiable {
    
    let id = UUID()
    
    let image: Image
    
}

extension HeartBubbleModel {
    
    static let dummyImages: [Image] = [
        Image("heart-bubble-1"),
        Image("heart-bubble-2"),
        Image("heart-bubble-3"),
        Image("heart-bubble-4"),
        Image("heart-bubble-5"),
        Image("heart-bubble-6"),
        Image("heart-bubble-7")
    ]
    
}
