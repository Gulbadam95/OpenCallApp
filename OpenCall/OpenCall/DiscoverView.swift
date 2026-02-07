//
//  DiscoverView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct DiscoverView: View {
    @State private var selectedTab = "PORTFOLIOS"
    // 1. Add your data state here
    @State private var creators = mockCreators
    
    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack {
                // Header
                Text("Casting Call")
                    .font(.custom("Georgia-Italic", size: 34))
                    .foregroundColor(CinemaTheme.goldHighlight)
                    .padding(.top)
                
                Text("Browse portfolios and open roles")
                    .font(.caption)
                    .italic()
                    .foregroundColor(.gray)
                
                // Segmented Control
                HStack(spacing: 0) {
                    TabButton(title: "PORTFOLIOS", active: selectedTab == "PORTFOLIOS") {
                        selectedTab = "PORTFOLIOS"
                    }
                    TabButton(title: "OPEN ROLES", active: selectedTab == "OPEN ROLES") {
                        selectedTab = "OPEN ROLES"
                    }
                }
                .background(Color.black.opacity(0.3))
                .padding()

                // 2. REPLACED ScrollView with a ZStack for the "Stack" effect
                ZStack {
                    if creators.isEmpty {
                        VStack {
                            Text("End of the Reel")
                                .font(.headline)
                                .foregroundColor(CinemaTheme.goldHighlight)
                            Button("Reload") { creators = mockCreators }
                                .padding()
                                .foregroundColor(.white)
                        }
                    } else {
                        ForEach(creators) { creator in
                            SwipeableCard(creator: creator) {
                                // Action when swiped: Remove the card from the array
                                withAnimation {
                                    creators.removeAll { $0.id == creator.id }
                                }
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

// 3. New Sub-View for the Swipe Logic
struct SwipeableCard: View {
    let creator: Creator
    var onSwipe: () -> Void
    
    @State private var offset = CGSize.zero

    var body: some View {
        FilmStripCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Circle()
                        .stroke(CinemaTheme.goldHighlight, lineWidth: 1)
                        .frame(width: 50, height: 50)
                        .overlay(Text(creator.initials).foregroundColor(CinemaTheme.goldHighlight))
                    
                    VStack(alignment: .leading) {
                        Text(creator.name).font(.headline).foregroundColor(.white)
                        Text(creator.role).font(.caption).foregroundColor(CinemaTheme.accentRed).bold()
                    }
                }
                
                Text(creator.bio)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    ForEach(creator.tags, id: \.self) { tag in
                        TagView(text: tag)
                    }
                }
            }
            .padding(.vertical)
        }
        // Apply the movement based on the drag
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 30)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 150 {
                        // SWIPE AWAY
                        withAnimation(.spring()) {
                            offset.width = offset.width > 0 ? 600 : -600
                            onSwipe()
                        }
                    } else {
                        // SNAP BACK
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
                }
        )
    }
}

struct TagView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .padding(8)
            .background(Color.white.opacity(0.05))
            .cornerRadius(4)
            .foregroundColor(.white)
    }
}

struct TabButton: View {
    let title: String
    let active: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(active ? CinemaTheme.goldHighlight.opacity(0.2) : Color.clear)
                .foregroundColor(active ? CinemaTheme.goldHighlight : .gray)
        }
    }
}
