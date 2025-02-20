//
//  SafeSpaceView.swift
//  PetTeddy
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 10)
                typingView
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            GeometryReader { geometry in
                VStack {
                    Rectangle()
                        .foregroundStyle(Color.yrCyanLight.opacity(0.3))
                        .background(.ultraThinMaterial)
                        .blur(radius: 1)
                        .frame(maxWidth: .infinity, maxHeight: geometry.safeAreaInsets.top)
                    Spacer()
                }
                .ignoresSafeArea()
            }
        }
        .onAppear { // NOTE: Send greeting message
            let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
            let message = MessageModel(
                date: date,
                text: Messages.safeSpaceGreetings.randomElement() ?? "Hi, how are you?",
                isSentByUser: false
            )

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                messages.append(message)
                scrollProxy?.scrollTo(message.id, anchor: .bottom) // 최신 메시지로 이동
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
                        VStack(alignment: message.isSentByUser ? .trailing : .leading, spacing: 5) {
                            Text(message.date)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundStyle(Color.yrGray)
                            ChatBubbleView(text: message.text, isSentByUser: message.isSentByUser)
                                .id(message.id)
                        }
                        .frame(maxWidth: .infinity, alignment: message.isSentByUser ? .trailing : .leading)
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onAppear {
                scrollProxy = proxy
            }
        }
    }
    
    
    // MARK: - Typing View
    
    var typingView: some View {
        
        HStack(alignment: .center, spacing: 6) {
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
        .padding(.vertical, 7)
        .padding(.horizontal, 10)
        .background(Color(.white))
    }
}


// MARK: - Methods

private extension SafeSpaceView {
    
    func sendMessage() {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let message = MessageModel(date: date, text: newMessage, isSentByUser: true)
        messages.append(message)
        newMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scrollProxy?.scrollTo(message.id, anchor: .bottom) // 최신 메시지로 이동
        }
    }
    
}
