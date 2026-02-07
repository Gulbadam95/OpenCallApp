//
//  ShortlistView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI


struct ShortlistView: View {
    @EnvironmentObject var store: AppStore
    
    // Track which creator is being messaged
    @State private var selectedCreatorForMessage: Creator?
    
    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // --- HEADER ---
                VStack(alignment: .leading) {
                    Color.clear.frame(height: 44) // Safe Area Spacer
                    Text("SELECTED TALENT")
                        .font(.custom("Georgia-Italic", size: 24))
                        .foregroundColor(CinemaTheme.goldHighlight)
                        .tracking(4)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .fill(CinemaTheme.goldHighlight.opacity(0.3))
                        .frame(height: 1)
                        .padding(.top, 8)
                }
                .background(CinemaTheme.deepCharcoal)
                
                if store.shortlist.isEmpty {
                    EmptyShortlistPlaceholder()
                } else {
                    // --- FILM STRIP LIST ---
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(store.shortlist) { creator in
                                FilmStripRow(creator: creator) {
                                    // Remove Action
                                    withAnimation {
                                        store.shortlist.removeAll { $0.id == creator.id }
                                    }
                                } onMessage: {
                                    // SET STATE TO TRIGGER SHEET
                                    selectedCreatorForMessage = creator
                                }
                            }
                        }
                        .padding(.vertical, 20)
                    }
                }
            }
        }
        // PRESENT MESSAGE VIEW AS A SHEET
        .sheet(item: $selectedCreatorForMessage) { creator in
            MessageComposeView(creator: creator)
        }
    }
}

// MARK: - Subviews
struct FilmStripRow: View {
    let creator: Creator
    var onRemove: () -> Void
    var onMessage: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            // Left Side: Profile Image Placeholder
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 100, height: 130)
                
                Text(creator.initials)
                    .font(.custom("Georgia-Bold", size: 28))
                    .foregroundColor(CinemaTheme.goldHighlight.opacity(0.6))
            }
            .border(CinemaTheme.goldHighlight.opacity(0.2), width: 1)
            
            // Middle: Information
            VStack(alignment: .leading, spacing: 4) {
                Text(creator.role.uppercased())
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(CinemaTheme.accentRed)
                    .tracking(2)
                
                Text(creator.name)
                    .font(.custom("Georgia-Bold", size: 22))
                    .foregroundColor(.white)
                
                Text(creator.tags.joined(separator: " • "))
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .italic()
            }
            .padding(.leading, 15)
            
            Spacer()
            
            // Right Side: Action Buttons
            VStack(spacing: 15) {
                Button(action: onMessage) {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(CinemaTheme.goldHighlight)
                        .clipShape(Circle())
                }
                
                Button(action: onRemove) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .padding(.trailing, 15)
        }
        .background(Color.white.opacity(0.03))
        .overlay(
            Rectangle()
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 4, dash: [8, 12])
                )
                .foregroundColor(Color.white.opacity(0.4))
                .padding(.vertical, -2)
        )
        .padding(.horizontal)
    }
}

struct EmptyShortlistPlaceholder: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "film.stack")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.3))
                .padding(.bottom, 10)
            Text("NO TALENT SELECTED YET")
                .font(.custom("Georgia-Italic", size: 14))
                .foregroundColor(.gray)
                .tracking(2)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Message View
struct MessageComposeView: View {
    let creator: Creator
    @Environment(\.dismiss) var dismiss
    @State private var messageText: String = ""
    @State private var isSent: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                CinemaTheme.deepCharcoal.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        Circle()
                            .fill(CinemaTheme.glassWhite)
                            .frame(width: 50, height: 50)
                            .overlay(Text(creator.initials).foregroundColor(CinemaTheme.goldHighlight))
                        
                        VStack(alignment: .leading) {
                            Text(creator.name)
                                .font(.custom("Georgia-Bold", size: 20))
                                .foregroundColor(.white)
                            Text(creator.role)
                                .font(.caption)
                                .foregroundColor(CinemaTheme.goldHighlight)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(15)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $messageText)
                            .padding(10)
                            .scrollContentBackground(.hidden) // Makes background visible on iOS 16+
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .font(.body)
                            .frame(height: 200)
                        
                        if messageText.isEmpty {
                            Text("Write your pitch...")
                                .foregroundColor(.gray)
                                .padding(.leading, 15)
                                .padding(.top, 18)
                                .allowsHitTesting(false)
                        }
                    }
                    
                    Button(action: {
                        if !messageText.isEmpty {
                            sendPitch()
                        }
                    }) {
                        HStack {
                            Text(isSent ? "MESSAGE SENT" : "SEND CASTING PITCH")
                            Image(systemName: isSent ? "checkmark.circle.fill" : "paperplane.fill")
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(isSent ? Color.green : CinemaTheme.goldHighlight)
                        .cornerRadius(12)
                    }
                    .disabled(isSent || messageText.isEmpty)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }.foregroundColor(CinemaTheme.goldHighlight)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func sendPitch() {
        withAnimation {
            isSent = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            dismiss()
        }
    }
}
