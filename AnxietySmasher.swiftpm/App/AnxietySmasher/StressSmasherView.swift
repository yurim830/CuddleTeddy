//
//  StressSmasherView.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

struct StressSmasherView: View {
    
    @State private var teddy: TeddyType = TeddyType.allCases.randomElement() ?? .teddy1
    
    @State private var heartBubbles: [HeartBubbleModel] = [] // Stores active heart-bubbles
    
    
    @State private var currentTeddyImageIndex = 0
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
    
}


// MARK: - UI Components

private extension StressSmasherView {
    
    var howAreYouLabel: some View {
        Text("Hi,\nhow are you?")
            .font(.system(.headline, design: .serif, weight: .medium))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.yrPurpleDark)
    }
    
    var tapMeLabel: some View {
        Text("Pet me\nand let it all out!")
            .font(.system(size: 20, weight: .regular, design: .monospaced))
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
        ZStack {
            teddy.images[currentTeddyImageIndex]
            heartBubblesView
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    switchTeddyImage()
                    addHeartBubble()
                }
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    if !isChanging {
                        isChanging = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            switchTeddyImage()
                            addHeartBubble()
                            isChanging = false
                        }
                    }
                }
        )
    }
    
    var heartBubblesView: some View {
        ZStack {
            ForEach(heartBubbles) { bubble in
                bubble.image
            }
        }
    }
    
}


// MARK: - Methods

extension StressSmasherView {
    
    private func switchTeddyImage() {
        currentTeddyImageIndex = (currentTeddyImageIndex + 1) % teddy.images.count
    }
    
    private func addHeartBubble() {
        // Add a heart bubble
        let newBubble = HeartBubbleModel(
            image: HeartBubbleModel.dummyImages.randomElement() ?? Image("heart-bubble-1")
        )
        
        heartBubbles.append(newBubble)
        
        // Remove after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            heartBubbles.removeAll { $0.id == newBubble.id }
        }
    }
    
}


// MARK: - Preview

#Preview {
    StressSmasherView()
}
