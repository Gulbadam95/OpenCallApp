//
//  DiscoverView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedCategory = "All"
    @State private var creators = mockCreators
    
    let categories = ["All", "Actor", "Crew", "Producer", "Director"]

    var filteredCreators: [Creator] {
        if selectedCategory == "All" {
            return creators
        } else {
            return creators.filter { $0.category == selectedCategory }
        }
    }

    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Color.clear.frame(height: 44)
                    
                    Text("CASTING CALL")
                        .font(.custom("Georgia-Italic", size: 22))
                        .foregroundColor(CinemaTheme.goldHighlight)
                        .tracking(3)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { cat in
                                CategoryButton(title: cat, isSelected: selectedCategory == cat) {
                                    withAnimation(.spring(response: 0.3)) {
                                        selectedCategory = cat
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 15)
                }
                .background(CinemaTheme.deepCharcoal)
                .zIndex(2)

                
                ZStack {
                    if filteredCreators.isEmpty {
                        EmptyStateView { creators = mockCreators }
                    } else {
                        ForEach(filteredCreators.reversed()) { creator in
                            SwipeableCard(creator: creator) { direction in
                                if direction == 1 {
                                    addToShortlist(creator)
                                }
                                withAnimation {
                                    creators.removeAll { $0.id == creator.id }
                                }
                            }
                        }
                    }
                }
                .padding(.top, 40)
                .padding(.bottom, 20)
                
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    func addToShortlist(_ creator: Creator) {
        store.shortlist.append(creator)
    }
}


struct SwipeableCard: View {
    let creator: Creator
    var onSwipe: (Int) -> Void

    @State private var offset = CGSize.zero

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.15), Color(white: 0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            
            GeometryReader { geo in
                if let imageName = creator.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
            }
            .mask(
                RoundedRectangle(cornerRadius: 24)
            )

            
            VStack(alignment: .leading, spacing: 10) {
                Text(creator.role.uppercased())
                    .font(.system(size: 12, weight: .black))
                    .foregroundColor(CinemaTheme.accentRed)
                    .tracking(2)

                Text(creator.name)
                    .font(.custom("Georgia-Bold", size: 32))
                    .foregroundColor(.white)

                Text(creator.bio)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)

                HStack(spacing: 8) {
                    ForEach(creator.tags, id: \.self) { tag in
                        TagView(text: tag)
                    }
                }
                .padding(.top, 5)
            }
            .padding(30)
            .background(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.85)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(24)
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: 520)
        .padding(.horizontal, 25)
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .overlay(
            ZStack {
                Text("SAVE")
                    .font(.system(size: 40, weight: .black))
                    .foregroundColor(.green)
                    .padding()
                    .border(Color.green, width: 4)
                    .opacity(Double(offset.width / 150))

                Text("SKIP")
                    .font(.system(size: 40, weight: .black))
                    .foregroundColor(.red)
                    .padding()
                    .border(Color.red, width: 4)
                    .opacity(Double(-offset.width / 150))
            }
        )
        .gesture(
            DragGesture()
                .onChanged { offset = $0.translation }
                .onEnded { _ in
                    if offset.width > 150 {
                        completeSwipe(direction: 1)
                    } else if offset.width < -150 {
                        completeSwipe(direction: -1)
                    } else {
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
                }
        )
    }

    func completeSwipe(direction: Int) {
        withAnimation(.easeInOut(duration: 0.3)) {
            offset.width = CGFloat(direction * 800)
            onSwipe(direction)
        }
    }
}





struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? CinemaTheme.goldHighlight : Color.white.opacity(0.05))
                .foregroundColor(isSelected ? .black : .white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? .clear : Color.white.opacity(0.1), lineWidth: 1)
                )
        }
    }
}

struct TagView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(CinemaTheme.glassWhite)
            .cornerRadius(4)
            .foregroundColor(.white.opacity(0.8))
    }
}

struct EmptyStateView: View {
    var onReset: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.and.background.dotted")
                .font(.system(size: 50))
                .foregroundColor(CinemaTheme.goldHighlight.opacity(0.5))
            Text("NO MORE TALENT FOUND")
                .font(.custom("Georgia-Bold", size: 16))
                .foregroundColor(.white)
            Button("RESET DISCOVERY") { onReset() }
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(CinemaTheme.goldHighlight)
                .padding()
                .background(CinemaTheme.glassWhite)
                .cornerRadius(10)
        }
    }
}
