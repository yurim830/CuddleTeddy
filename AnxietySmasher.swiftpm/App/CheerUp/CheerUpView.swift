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
                Image("faceSmile")
                
                cheerUpMessageZStack
                    .padding(.horizontal, 40)
                
                refreshButton
            }
        }
    }
    
    
    var cheerUpMessageZStack: some View {
        ZStack(alignment: .center) {
            Image("chatBubbleOrg")
                .resizable()
                .scaledToFit()
//                .frame(width: 280 * ScreenUtils.widthRatio)

            Text(cheerUpMessage)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.white)
//                .frame(width: 254 * ScreenUtils.widthRatio)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .offset(y: 10)
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
                .foregroundStyle(Color("yrYellowDark"))
                .italic(true)
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
