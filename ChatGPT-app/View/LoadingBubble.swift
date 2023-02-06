//
//  LoadingBubble.swift
//  ChatGPT-app
//
//  Created by Marcin Bartminski on 06/02/2023.
//

import SwiftUI

struct LoadingBubble: View {
    
    @State var currentHighlight = 0
    
    let timer = Timer.publish(every: 0.75, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                Text("●")
                    .opacity(currentHighlight == 0 ? 1.0 : 0.5)
                Text("●")
                    .opacity(currentHighlight == 1 ? 1.0 : 0.5)
                Text("●")
                    .opacity(currentHighlight == 2 ? 1.0 : 0.5)
            }
            .font(.system(size: 10))
            .foregroundColor(Color(uiColor: .systemGray))
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(20)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .onReceive(timer) { _ in
            withAnimation {
                currentHighlight += 1
                if currentHighlight > 2 {
                    currentHighlight = 0
                }
            }
        }
    }
}

struct LoadingBubble_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ChatBubble(ChatMessage(text: "Hello!", messageFrom: .user))
            ChatBubble(ChatMessage(text: "Hello User!", messageFrom: .chatGPT))
            LoadingBubble()
        }
    }
}
