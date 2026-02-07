//
//  MessagesListView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import Foundation
import SwiftUI

struct MessagesListView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedFolder: String = "Messages"
    
    var body: some View {
        NavigationStack {
            ZStack {
                CinemaTheme.deepCharcoal.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Custom Header Toggle
                    HStack(spacing: 20) {
                        FolderButton(title: "MESSAGES", count: store.activeConversations.count, isActive: selectedFolder == "Messages") {
                            selectedFolder = "Messages"
                        }
                        FolderButton(title: "REQUESTS", count: 3, isActive: selectedFolder == "Requests") {
                            selectedFolder = "Requests"
                        }
                    }
                    .padding()
                    
                    Divider().background(Color.gray.opacity(0.3))

                    ScrollView {
                        VStack(spacing: 0) {
                            // MARK: - Programmatic Navigation Trigger
                            // This invisible link activates when 'navigatedPerson' is set in the AppStore
                            if let personToChat = store.navigatedPerson {
                                NavigationLink(
                                    destination: ChatDetailView(appStore: store, person: personToChat),
                                    // Using a binding allows us to "reset" the navigation state when the user goes back
                                    isActive: Binding(
                                        get: { store.navigatedPerson != nil },
                                        set: { if !$0 { store.navigatedPerson = nil } }
                                    )
                                ) {
                                    EmptyView()
                                }
                            }

                            if selectedFolder == "Messages" {
                                ForEach(store.activeConversations) { person in
                                    NavigationLink(destination: ChatDetailView(appStore: store, person: person)) {
                                        MessageRow(person: person)
                                    }
                                }
                            } else {
                                // For requests folder
                                NavigationLink(destination: TalentDetailView(person: SearchResult(name: "Casting Director", role: "PRODUCER", specialty: "Action", imageName: "1"))) {
                                    MessageRow(person: SearchResult(name: "Casting Director", role: "PRODUCER", specialty: "Action", imageName: "2"), isRequest: true)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("OFFICE INBOX")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MessageRow: View {
    let person: SearchResult
    var isRequest: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 15) {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 55, height: 55)
                    .overlay(
                        Text(person.name.prefix(1))
                            .foregroundColor(CinemaTheme.goldHighlight)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(person.name.uppercased())
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Text("12:45 PM")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                    
                    Text(isRequest ? "Wants to collaborate on a new project..." : (person.messages.last?.content ?? "No messages yet"))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            .padding()
            
            Divider().background(Color.white.opacity(0.05))
        }
    }
}

struct FolderButton: View {
    let title: String
    let count: Int
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(isActive ? CinemaTheme.goldHighlight : .gray)
                
                if isActive {
                    Rectangle()
                        .fill(CinemaTheme.goldHighlight)
                        .frame(width: 40, height: 2)
                } else {
                    // Keeps layout stable when switching
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 40, height: 2)
                }
            }
        }
    }
}
