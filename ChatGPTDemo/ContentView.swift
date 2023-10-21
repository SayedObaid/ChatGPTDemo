//
//  ContentView.swift
//  ChatGPTDemo
//
//  Created by Sayed Obaid on 24/09/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    @State private var newMessage = ""
    
    var body: some View {
        VStack {
            MessagesListView(messages: viewModel.messages) // Display chat messages
            HStack {
                TextField("Enter your message", text: $newMessage) // Input field
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Text("Send") // Button to send a message
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .onAppear {
            viewModel.setupOpenAI() // Initialize OpenAI when the view appears
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        viewModel.sendUserMessage(newMessage) // Send user's message to view model
        newMessage = "" // Clear the input field
    }
}

struct MessagesListView: View {
    var messages: [ChatMessage]
    
    var body: some View {
        List(messages) { message in
            MessageRow(message: message) // Display individual chat messages
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}

struct MessageRow: View {
    var message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.message)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            } else {
                Text(message.message)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
