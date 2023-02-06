//
//  ChatMessage.swift
//  ChatGPT-app
//
//  Created by Marcin Bartminski on 06/02/2023.
//

import Foundation

struct ChatMessage: Identifiable {
    var text: String
    let messageFrom: MessageFrom
    
    let id = UUID()
    
    
    enum MessageFrom {
        case user
        case chatGPT
    }
}
