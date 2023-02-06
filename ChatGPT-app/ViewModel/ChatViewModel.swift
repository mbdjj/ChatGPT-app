//
//  ChatViewModel.swift
//  ChatGPT-app
//
//  Created by Marcin Bartminski on 06/02/2023.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    
    @Published var messages = [ChatMessage]()
    @Published var messagesPlaceholder = [
        ChatMessage(text: "Hello!", messageFrom: .user),
        ChatMessage(text: "Hello User!", messageFrom: .chatGPT),
        ChatMessage(text: "Who is Marcin?", messageFrom: .user),
        ChatMessage(text: "Marcin is a programmer of this chat app!", messageFrom: .chatGPT)
    ]
    
    @Published var message = ""
    @Published var isWriting = false
    
    @Published var count = 0
    
    let api = ChatGPTAPI(apiKey: "your Api Key here")
    
    func sendMessage(_ text: String) async {
        messages.append(ChatMessage(text: text, messageFrom: .user))
        scrollToBottom()
        
        
        let answer = ChatMessage(text: "", messageFrom: .chatGPT)
        messages.append(answer)
        scrollToBottom()
        
        DispatchQueue.main.async {
            withAnimation {
                self.message = ""
                self.isWriting = true
            }
        }
        
        let index = messages.firstIndex { message in
            message.id == answer.id
        }
        
        do {
            let stream = try await api.sendMessageStream(text: text)
            for try await line in stream {
                
                DispatchQueue.main.async {
                    self.messages[index!].text += line
                    
                    if self.messages[index!].text.hasPrefix(" ") {
                        self.messages[index!].text.removeFirst()
                    }
                }
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        DispatchQueue.main.async {
            withAnimation {
                self.isWriting = false
            }
        }
    }
    
    func scrollToBottom() {
        self.count += 1
    }
    
    func copy(_ message: ChatMessage) {
        UIPasteboard.general.string = message.text
    }
    
}
