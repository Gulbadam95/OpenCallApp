//
//  AppStore.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

class AppStore: ObservableObject {
    @Published var activeConversations: [SearchResult] = []
    @Published var selectedTab: Int = 0
    @Published var navigatedPerson: SearchResult?
    @Published var shortlist: [Creator] = []
    
    func startConversation(with person: SearchResult) {
        // 1. Add to list if not already there
        if !activeConversations.contains(where: { $0.id == person.id }) {
            activeConversations.append(person)
        }
        
        // 2. Prepare for navigation
        self.navigatedPerson = person
        self.selectedTab = 1 // Switch to the Messages Tab
    }
    
    
    func sendMessage(to person: SearchResult, content: String) {
        if let index = activeConversations.firstIndex(where: { $0.id == person.id }) {
            let newMsg = Message(content: content, isUser: true, timestamp: Date())
            activeConversations[index].messages.append(newMsg)
        }
    }
}
