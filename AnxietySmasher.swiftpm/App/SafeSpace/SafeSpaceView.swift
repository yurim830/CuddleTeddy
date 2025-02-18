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

    var body: some View {
        VStack {
            // 메시지 목록
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(messages) { message in
                            messageView(message: message)
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

            // 입력창 + 보내기 버튼
            HStack {
                TextField("Express your thoughts...", text: $newMessage)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .modifier(KeyboardAwareModifier()) // 키보드 감지
        }
    }

    // 메시지 추가 함수
    func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let message = MessageModel(date: date, text: newMessage, isSentByUser: Bool.random()) // 랜덤 발신자 지정 (테스트용)
        messages.append(message)
        newMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scrollProxy?.scrollTo(message.id, anchor: .bottom) // 최신 메시지로 이동
        }
    }
}

// 채팅 말풍선 모양 (꼬리 포함)
struct ChatBubbleShape: Shape {
    let isSentByUser: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 16
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: radius, height: radius))

        let tailSize: CGFloat = 10
        let tailOffset: CGFloat = 5

        if isSentByUser {
            path.move(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY - tailOffset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - tailSize, y: rect.maxY + tailSize))
        } else {
            path.move(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY - tailOffset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + tailSize, y: rect.maxY + tailSize))
        }
        
        return path
    }
}

// 키보드가 올라올 때 자동으로 따라가도록 하는 Modifier
struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .animation(.easeOut(duration: 0.3), value: keyboardHeight)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                       object: nil,
                                                       queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                        keyboardHeight = keyboardFrame.height - 34 // 홈바 고려
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                       object: nil,
                                                       queue: .main) { _ in
//                    keyboardHeight = 0
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
    
    func messageView(message: MessageModel) -> some View {
        var messageView: some View {
            HStack {
                if !message.isSentByUser { Spacer() }
                
                VStack(alignment: message.isSentByUser ? .trailing : .leading) {
                    Text(message.date)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(message.text)
                        .padding()
                        .background(message.isSentByUser ? Color.blue : Color.white)
                        .clipShape(ChatBubbleShape(isSentByUser: message.isSentByUser))
                        .foregroundColor(message.isSentByUser ? .white : .black)
                        .frame(maxWidth: 250, alignment: .leading)
                }
                
                if message.isSentByUser { Spacer() }
            }
        }
        
        return messageView
    }
}
