//
//  ChatBubbleView.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/18/25.
//

import SwiftUI

struct ChatBubbleView: View {
    
    let text: String
    let isSentByUser: Bool
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .regular))
            .padding(12)
            .background(
                ChatBubbleShape(isSentByUser: isSentByUser)
                    .fill(isSentByUser ? Color.blue : Color.gray.opacity(0.2))
            )
            .foregroundColor(isSentByUser ? .white : .black)
            .frame(maxWidth: 250, alignment: isSentByUser ? .trailing : .leading)
            .padding(isSentByUser ? .leading : .trailing, 40)
            .padding(.vertical, 5)
    }
    
}

