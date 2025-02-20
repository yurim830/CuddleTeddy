//
//  StressSmasherView.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

struct StressSmasherView: View {
    
    @State private var teddy: TeddyType = TeddyType.allCases.randomElement() ?? .teddy1
    
    @State private var currentBodyIndex = 0
    @State private var isChanging = false // Prevents rapid changes
    
    var body: some View {
        
        ZStack {
            Color.yrPurpleLight
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                tapMeLabel
                    .padding(30)
                characterView
                Spacer()
                HStack {
                    Spacer()
                    changeFaceButton
                }
                .padding(20)
            }
        }
    }
    
    var howAreYouLabel: some View {
        Text("Hi,\nhow are you?")
            .font(.system(.headline, design: .serif, weight: .medium))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.yrPurpleDark)
    }
    
    var tapMeLabel: some View {
        Text("Pet me\nand let it all out!")
            .font(.system(size: 26, weight: .regular, design: .monospaced))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.yrPurpleDark)
    }
    
    var changeFaceButton: some View {
        Button {
            teddy = (TeddyType.allCases.randomElement() ?? .teddy1)
        } label: {
            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                .foregroundStyle(Color.yrPurpleDark)
            Text("change face")
                .foregroundStyle(Color.yrPurpleDark)
                .font(.system(size: 15))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background {
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.yrPurpleDark)
        }
    }
    
    var characterView: some View {
        teddy.images[currentBodyIndex]
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    currentBodyIndex = (currentBodyIndex + 1) % 2
                }
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    if !isChanging {
                        isChanging = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            currentBodyIndex = (currentBodyIndex + 1) % 2
                            isChanging = false
                        }
                    }
                }
        )
    }
}

#Preview {
    StressSmasherView()
}
