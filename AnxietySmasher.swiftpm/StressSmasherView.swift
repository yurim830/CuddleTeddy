//
//  StressSmasherView.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

struct StressSmasherView: View {
    
    @State private var faceImage: Image = (FaceType.allCases.randomElement()?.image ?? .faceHappy)
    
    @State private var bodyImages: [Image] = [
        Image("body1"),
        Image("body2")
    ]
    
    @State private var currentBodyIndex = 0
    
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
        Text("Tap me\nand let it all out!")
            .font(.system(size: 30, weight: .regular))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.yrPurpleDark)
    }
    
    var changeFaceButton: some View {
        Button {
            faceImage = (FaceType.allCases.randomElement()?.image ?? .faceHappy)
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
        VStack(spacing: -10) {
            faceImage
            bodyImages[currentBodyIndex]
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
        .onTapGesture {
            currentBodyIndex = (currentBodyIndex + 1) % bodyImages.count
        }
    }
}

#Preview {
    StressSmasherView()
}
