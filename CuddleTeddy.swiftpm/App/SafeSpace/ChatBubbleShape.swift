//
//  ChatBubbleShape.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/18/25.
//

import SwiftUI

// MARK: - 채팅 말풍선 모양 (꼬리 포함)

struct ChatBubbleShape: Shape {
    
    let isSentByUser: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 16
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: radius, height: radius))

        let tailHeight: CGFloat = 10
        let tailWidth: CGFloat = 12
        
        let safeStartX: CGFloat = isSentByUser ? rect.maxX - 20 : rect.minX + 20

        if isSentByUser {
            path.move(to: CGPoint(x: safeStartX, y: rect.maxY - tailHeight))
            path.addLine(to: CGPoint(x: rect.maxX + tailWidth, y: rect.maxY))
            path.addLine(to: CGPoint(x: safeStartX, y: rect.maxY))
            path.addLine(to: CGPoint(x: safeStartX, y: rect.maxY - tailHeight))
        } else {
            path.move(to: CGPoint(x: safeStartX, y: rect.maxY - tailHeight))
            path.addLine(to: CGPoint(x: rect.minX - tailWidth, y: rect.maxY))
            path.addLine(to: CGPoint(x: safeStartX, y: rect.maxY))
            path.addLine(to: CGPoint(x: safeStartX, y: rect.maxY - tailHeight))
        }
        
        return path
    }
    
}
