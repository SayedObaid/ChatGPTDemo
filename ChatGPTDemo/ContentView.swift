//
//  ContentView.swift
//  ChatGPTDemo
//
//  Created by Sayed Obaid on 24/09/2023.
//

import SwiftUI

// Define a ChatMessage struct with id, message, and isUser properties.
struct ChatMessage: Identifiable {
    var id = UUID()
    var message: String
    var isUser: Bool
}

struct ContentView: View {
    @State private var messages: [ChatMessage] = []    // State to manage chat messages
    @State private var newMessage = ""                  // State to store user's new message
    @ObservedObject var viewModel = ChatViewModel()      // View model for chat functionality
    
    var body: some View {
        VStack {
            // Display chat messages in a list
            List(messages) { message in
                MessageRow(message: message)
            }
            .listStyle(.plain)
            .background(Color.clear)
            
            HStack {
                // Input field for entering a new message
                TextField("Enter your message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Button to send a message
                Button(action: sendMessage) {
                    Text("Send")
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .onAppear {
            // Initialize the OpenAI chat service when the view appears
            viewModel.setupOpenAI()
        }
    }
    
    // Function to send a new user message
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        let message = ChatMessage(message: newMessage, isUser: true)
        messages.append(message)
        newMessage = ""
        
        // Call the view model to send the user message to OpenAI
        viewModel.sendMessage(message: newMessage) { response in
            showResponse(response: response)
        }
    }
    
    // Function to display the response from OpenAI
    func showResponse(response: String) {
        let response = ChatMessage(message: response, isUser: false)
        messages.append(response)
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
