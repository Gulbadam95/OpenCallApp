//
//  ContentView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import SwiftUI

struct ContentView: View {
    init() {
        // Dark theme for the tab bar
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    var body: some View {
        TabView {
            // Tab 1: Now Screening
            ScreeningView()
                .tabItem {
                    Label("Screening", systemImage: "film")
                }
            
            // Tab 2: The Discover/Swipe view we just built
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            
            // Tab 3 & 4 (Placeholders for now)
            Color.black.tabItem { Label("Matches", systemImage: "bubble.left") }
            Color.black.tabItem { Label("Profile", systemImage: "person") }
        }
        .accentColor(CinemaTheme.goldHighlight)
    }
}

#Preview {
    ContentView()
}
