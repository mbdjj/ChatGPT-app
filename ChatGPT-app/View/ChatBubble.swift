//
//  ChatBubble.swift
//  ChatGPT-app
//
//  Created by Marcin Bartminski on 06/02/2023.
//

import SwiftUI

struct ChatBubble: View {
    
    let message: ChatMessage
    
    init(_ message: ChatMessage) {
        self.message = message
    }
    
    var body: some View {
        if message.messageFrom == .user {
            HStack {
                
                Spacer(minLength: 38)
                
                HStack {
                    Text(message.text)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .cornerRadius(20)
            }
            .padding(.horizontal, 20)
        } else {
            HStack {
                
                HStack {
                    Text(message.text)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(20)
                
                Spacer(minLength: 38)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ChatBubble(ChatMessage(text: "Hello!", messageFrom: .user))
            ChatBubble(ChatMessage(text: "Hello User!", messageFrom: .chatGPT))
        }
    }
}
