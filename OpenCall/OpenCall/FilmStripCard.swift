//
//  FilmStripCard.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct FilmStripCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            // Main Card Background
            RoundedRectangle(cornerRadius: 12)
                .fill(CinemaTheme.filmGrey.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )

            HStack(spacing: 0) {
                
                SprocketColumn()
                
                
                content
                    .padding(.horizontal, 10)
                
                
                SprocketColumn()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}


struct SprocketColumn: View {
    var body: some View {
        VStack(spacing: 12) {
            ForEach(0..<10) { _ in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 8, height: 10)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 6)
    }
}
