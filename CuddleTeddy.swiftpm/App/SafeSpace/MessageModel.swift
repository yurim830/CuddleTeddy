//
//  MessageModel.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/18/25.
//

import Foundation

struct MessageModel: Identifiable {
    
    let id = UUID()
    let date: String
    let text: String
    let isSentByUser: Bool
    
}
