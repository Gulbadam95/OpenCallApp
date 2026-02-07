//
//  ChatDetailView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var appStore: AppStore
    let person: SearchResult
    @State private var messageText: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. Message List
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(person.messages) { message in
                                ChatBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                    }
                    .onChange(of: person.messages.count) { _ in
                        // Auto-scroll to bottom when new message arrives
                        if let lastId = person.messages.last?.id {
                            withAnimation { proxy.scrollTo(lastId, anchor: .bottom) }
                        }
                    }
                }

                // 2. Input Area
                messageInputArea
            }
        }
        .navigationTitle(person.name.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(CinemaTheme.deepCharcoal, for: .navigationBar)
    }

    private var messageInputArea: some View {
        VStack(spacing: 0) {
            Divider().background(Color.white.opacity(0.1))
            
            HStack(spacing: 15) {
                TextField("TYPE A MESSAGE...", text: $messageText)
                    .font(.system(size: 13))
                    .padding(12)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(messageText.isEmpty ? .gray : CinemaTheme.goldHighlight)
                        .font(.system(size: 18))
                }
                .disabled(messageText.isEmpty)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(CinemaTheme.deepCharcoal)
        }
    }

    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        appStore.sendMessage(to: person, content: messageText)
        messageText = ""
    }
}

// MARK: - Chat Bubble Component
struct ChatBubble: View {
    let message: Message // Assuming your Message model has 'content' and 'isUser'
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.content)
                .font(.system(size: 14))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(message.isUser ? CinemaTheme.goldHighlight : Color.white.opacity(0.1))
                .foregroundColor(message.isUser ? .black : .white)
                .cornerRadius(18)
                .frame(maxWidth: 260, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}
