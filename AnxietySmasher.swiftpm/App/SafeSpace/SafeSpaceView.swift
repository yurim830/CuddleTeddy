//
//  SafeSpaceView.swift
//  AnxietySmasher
//
//  Created by 김유림 on 2/18/25.


import SwiftUI

struct SafeSpaceView: View {
    
    @State private var messages: [MessageModel] = []
    @State private var newMessage: String = ""
    @State private var scrollProxy: ScrollViewProxy?
    @FocusState private var isDescriptionFocused: Bool

    var body: some View {
        ZStack {
            Color.yrCyanLight
                .ignoresSafeArea()
            
            VStack {
                messageScrollView
                typingView
            }
        }
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        SafeSpaceView()
    }
}


// MARK: - UI Components

private extension SafeSpaceView {
    
    // MARK: - Messages
    
    var messageScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        ChatBubbleView(text: message.text, isSentByUser: message.isSentByUser)
                            .padding(.horizontal)
                            .id(message.id) // 스크롤 이동을 위한 ID
                    }
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .onAppear {
                scrollProxy = proxy
            }
        }
    }
    
    
    // MARK: - Typing View
    
    var typingView: some View {
        
        HStack(alignment: .bottom, spacing: 6) {
            TextEditor(text: $newMessage)
                .asTextEditorStyle(
                    placeholder: "Express your thoughts...",
                    text: $newMessage,
                    maximumTextLength: 100,
                    isFocused: $isDescriptionFocused
                )
                .focused($isDescriptionFocused)

            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.yrCyanDark)
                    
            }
        }
        .padding()
        .background(Color(.white))
    }
}


// MARK: - Methods

private extension SafeSpaceView {
    
    func sendMessage() {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let message = MessageModel(date: date, text: newMessage, isSentByUser: .random()) // 랜덤 발신자 지정 (테스트용)
        messages.append(message)
        newMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scrollProxy?.scrollTo(message.id, anchor: .bottom) // 최신 메시지로 이동
        }
    }
    
}
