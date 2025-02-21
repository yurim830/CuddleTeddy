//
//  PetTeddyView.swift
//  CuddleTeddy
//
//  Created by Yurim Kim on 2/18/25.
//

import SwiftUI
import AVFoundation

struct PetTeddyView: View {
    
    @State private var teddy: TeddyType = TeddyType.allCases.randomElement() ?? .teddy1
    
    @State private var bubbles: [TeddyBubbleModel] = []
    
    @State private var currentTeddyImageIndex = 0
    @State private var isChangingTeddy = false
    @State private var isChangingBubble = false
    
    var body: some View {
        
        ZStack {
            Color.yrPurpleLight
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                tapMeLabel
                characterView
                    .padding(.horizontal, 20)
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    changeTeddyButton
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                }
            }
        }
    }
    
}


// MARK: - UI Components

private extension PetTeddyView {
    
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
    
    var changeTeddyButton: some View {
        Button {
            teddy = (TeddyType.allCases.randomElement() ?? .teddy1)
        } label: {
            if #available(iOS 18.0, *) {
                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    .foregroundStyle(Color.yrPurpleDark)
            } else {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .foregroundStyle(Color.yrPurpleDark)
            }
            
            Text("change teddy")
                .foregroundStyle(Color.yrPurpleDark)
                .font(.system(size: 14))
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
                .resizable()
                .scaledToFit()
                .frame(width: 209, height: 295)
            heartBubblesView
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    switchTeddyImage()
                    addHeartBubble()
                    playHapticFeedback()
                    playSound()
                }
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { _ in
                    if !isChangingTeddy {
                        isChangingTeddy = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            switchTeddyImage()
                            isChangingTeddy = false
                        }
                    }
                    
                    if !isChangingBubble {
                        isChangingBubble = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            addHeartBubble()
                            playHapticFeedback()
                            playSound()
                            isChangingBubble = false
                        }
                    }
                }
        )
    }
    
    var heartBubblesView: some View {
        ZStack {
            Image("empty-bubble")
                .resizable()
                .scaledToFit()
            ForEach(bubbles) { bubble in
                bubble.image
                    .resizable()
                    .scaledToFit()
            }
        }
    }
    
}


// MARK: - Methods

private extension PetTeddyView {
    
    func switchTeddyImage() {
        currentTeddyImageIndex = (currentTeddyImageIndex + 1) % teddy.images.count
    }
    
    func addHeartBubble() {
        // Add a heart bubble
        let newBubble = TeddyBubbleModel(
            image: TeddyBubbleModel.dummyImages.randomElement() ?? Image("heart-bubble-1")
        )
        
        bubbles.append(newBubble)
        
        // Remove after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            bubbles.removeAll { $0.id == newBubble.id }
        }
    }
    
    func playSound() {
        AudioServicesPlaySystemSound(1004)
    }
    
    func playHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
}


// MARK: - Preview

#Preview {
    PetTeddyView()
}
