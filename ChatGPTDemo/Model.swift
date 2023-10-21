//
//  Model.swift
//  ChatGPTDemo
//
//  Created by Sayed Obaid on 24/09/2023.
//

import Foundation

// Define a ChatMessage struct with id, message, and isUser properties.
struct ChatMessage: Identifiable {
    var id = UUID()
    var message: String
    var isUser: Bool
}
