//
//  CustomTabView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import SwiftUI

struct CustomTabView: View {
    @State private var activeTab: Tab = .discover
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 1. Content Switcher
            Group {
                switch activeTab {
                case .search:
                    SearchView()
                case .matches:
                    // This will eventually be your 'Shortlist'
                    Text("Shortlist / Matches").foregroundColor(.white)
                case .discover:
                    DiscoverView()
                case .messages:
                    Text("Messages").foregroundColor(.white)
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 2. The Custom Tab Bar
            ZStack {
                // Background Bar
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 90)
                    .overlay(
                        Rectangle()
                            .fill(CinemaTheme.goldHighlight.opacity(0.5))
                            .frame(height: 0.5), alignment: .top
                    )
                
                // The Buttons
                HStack(spacing: 0) {
                    // LEFT SIDE
                    TabItem(icon: "magnifyingglass", label: "SEARCH", isActive: activeTab == .search) {
                        activeTab = .search
                    }
                    
                    TabItem(icon: "star.fill", label: "SHORTLIST", isActive: activeTab == .matches) {
                        activeTab = .matches
                    }
                    
                    // SPACE FOR BIG CENTER BUTTON
                    Spacer().frame(width: 90)
                    
                    // RIGHT SIDE
                    TabItem(icon: "bubble.left.and.bubble.right.fill", label: "MESSAGES", isActive: activeTab == .messages) {
                        activeTab = .messages
                    }
                    
                    TabItem(icon: "person.fill", label: "PROFILE", isActive: activeTab == .profile) {
                        activeTab = .profile
                    }
                }
                .padding(.bottom, 20)
                
                // 3. THE BIG CENTER BUTTON (Discover/Swipe)
                Button(action: { activeTab = .discover }) {
                    ZStack {
                        Circle()
                            .fill(CinemaTheme.deepCharcoal)
                            .frame(width: 75, height: 75)
                            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                        
                        Circle()
                            .stroke(CinemaTheme.goldHighlight, lineWidth: 2)
                            .frame(width: 65, height: 65)
                        
                        // Small "Film Reel" notches
                        Circle()
                            .stroke(activeTab == .discover ? CinemaTheme.accentRed : Color.gray.opacity(0.3), lineWidth: 1)
                            .frame(width: 72, height: 72)
                        
                        Image(systemName: "film.stack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(activeTab == .discover ? CinemaTheme.goldHighlight : .gray)
                    }
                }
                .offset(y: -38)
            }
        }
        .ignoresSafeArea()
    }
}

// Helper for the smaller side buttons
struct TabItem: View {
    let icon: String
    let label: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.system(size: 10, weight: .bold))
            }
            .foregroundColor(isActive ? CinemaTheme.goldHighlight : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}


#Preview {
    CustomTabView()
}
