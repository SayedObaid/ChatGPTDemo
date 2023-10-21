//
// ChatViewModel.swift
// ChatGPTDemo
//
// Created by Sayed Obaid on 24/09/2023.
//

import Foundation
import OpenAISwift

final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [] // Published property for chat messages

    private var openAI: OpenAISwift?

    init() {}

    func setupOpenAI() {
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config) // Initialize OpenAI
    }

    func sendUserMessage(_ message: String) {
        let userMessage = ChatMessage(message: message, isUser: true)
        messages.append(userMessage) // Append user message to chat history

        openAI?.sendCompletion(with: message, maxTokens: 500) { [weak self] result in
            switch result {
            case .success(let model):
                if let response = model.choices?.first?.text {
                    self?.receiveBotMessage(response) // Handle bot's response
                }
            case .failure(_):
                // Handle any errors during message sending
                break
            }
        }
    }

    private func receiveBotMessage(_ message: String) {
        let botMessage = ChatMessage(message: message, isUser: false)
        messages.append(botMessage) // Append bot message to chat history
    }
}
