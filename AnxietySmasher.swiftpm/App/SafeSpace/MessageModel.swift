//
//  MessageModel.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import Foundation

struct MessageModel: Identifiable {
    
    let id = UUID()
    let date: String
    let text: String
    let isSentByUser: Bool
    
}
