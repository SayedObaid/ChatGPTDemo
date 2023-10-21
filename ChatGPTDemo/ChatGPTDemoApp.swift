//
//  ChatGPTDemoApp.swift
//  ChatGPTDemo
//
//  Created by Sayed Obaid on 24/09/2023.
//

import SwiftUI

@main
struct ChatGPTDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ChatViewModel())
        }
    }
}
