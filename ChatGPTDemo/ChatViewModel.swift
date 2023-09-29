//
// ChatViewModel.swift
// ChatGPTDemo
//
// Created by Sayed Obaid on 24/09/2023.
//

import Foundation
import OpenAISwift

// Define a class for managing chat interactions
final class ChatViewModel: ObservableObject {
    init () {}
    
    private var openAI: OpenAISwift?
    
    // Initialize OpenAI with an API key
    func setupOpenAI(){
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config)
    }
    
    // Send a message to OpenAI for completion
    func sendMessage(message: String, completionHandler: @escaping (String) -> Void){
        openAI?.sendCompletion(with: message, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                // Extract the response text from the model's choices
                let response = model.choices?.first?.text ?? ""
                completionHandler(response)
            case .failure(_):
                // Handle any errors during message sending
                break;
            }
        })
    }
}
