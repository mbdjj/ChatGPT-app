//
//  ContentView.swift
//  ChatGPT-app
//
//  Created by Marcin Bartminski on 06/02/2023.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ScrollViewReader { proxy in
                        Spacer()
                        ForEach(viewModel.messages) { message in
                            ChatBubble(message)
                        }
                        
                        if viewModel.isWriting {
                            LoadingBubble()
                        }
                        
                        Spacer()
                            .id("empty")
                            .onReceive(viewModel.$count) { _ in
                                withAnimation(.easeOut(duration: 0.5)) {
                                    proxy.scrollTo("empty", anchor: .bottom)
                                }
                            }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                
                HStack {
                    TextField("Message", text: $viewModel.message)
                        .padding(.leading, 12)
                    
                    Button {
                        Task {
                            await viewModel.sendMessage(viewModel.message)
                            viewModel.scrollToBottom()
                        }
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(13)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 4)
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 17).stroke().foregroundColor(Color(uiColor: .systemGray4)))
                .padding(.horizontal)
                .padding(.vertical, 6)
                
            }
            .navigationTitle("ChatGPT")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatViewPreviews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
