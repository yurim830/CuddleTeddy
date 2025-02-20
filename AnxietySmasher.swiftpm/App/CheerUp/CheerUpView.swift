//
//  CheerUpView.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

struct CheerUpView: View {
    
    @State private var cheerUpMessage: String
    
    
    init() {
        _cheerUpMessage = State(initialValue: Messages.cheerUpMessages.randomElement() ?? "You're doing great!")
    }
    
    var body: some View {
        ZStack {
            Color.yrYellowLight
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image.teddyHead
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                cheerUpMessageZStack
                    .padding(.horizontal, 40)
                
                refreshButton
            }
        }
    }
    
    
    var cheerUpMessageZStack: some View {
        ZStack(alignment: .center) {
            Image.chatBubble
                .resizable()
                .scaledToFit()

            Text(cheerUpMessage)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .offset(y: 10)
                .padding(20)
        }
    }
    
    var refreshButton: some View {
        Button {
            refreshMessage()
        } label: {
            Text("Refresh")
                .font(
                    Font.system(size: 24, weight: .semibold, design: .serif)
                )
                .foregroundStyle(Color.yrYellowDark)
                .underline()
        }
    }
    
    
    func refreshMessage() {
        cheerUpMessage = Messages.cheerUpMessages.randomElement() ?? "Stay positive!"
    }
}

#Preview {
    CheerUpView()
}
