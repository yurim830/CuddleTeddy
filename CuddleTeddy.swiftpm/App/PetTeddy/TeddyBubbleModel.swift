//
//  TeddyBubbleModel.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/21/25.
//

import SwiftUI

struct TeddyBubbleModel: Identifiable {
    
    let id = UUID()
    
    let image: Image
    
}

extension TeddyBubbleModel {
    
    static let dummyImages: [Image] = [
        Image("heart-bubble-1"),
        Image("heart-bubble-2"),
        Image("heart-bubble-3"),
        Image("heart-bubble-4"),
        Image("heart-bubble-5"),
        Image("heart-bubble-6"),
        Image("heart-bubble-7"),
        Image("clover-bubble-1"),
        Image("clover-bubble-2"),
        Image("clover-bubble-3"),
        Image("clover-bubble-4"),
        Image("clover-bubble-5"),
        Image("clover-bubble-6"),
        Image("clover-bubble-7"),
        Image("word-bubble-1"),
        Image("word-bubble-2"),
        Image("word-bubble-3"),
        Image("word-bubble-4"),
        Image("word-bubble-5"),
        Image("word-bubble-6")
    ]
    
}
