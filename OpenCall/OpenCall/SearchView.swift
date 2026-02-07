//
//  SearchView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedGenre = "All"
    let genres = ["All", "Horror", "Indie", "Noir", "Drama", "Sci-Fi"]

    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Archive Search")
                    .font(.custom("Georgia-Italic", size: 30))
                    .foregroundColor(CinemaTheme.goldHighlight)
                    .padding()

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Roles, Genres, or Names...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(10)
                .padding(.horizontal)
                .foregroundColor(.white)

                Text("FILTER BY GENRE")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.gray)
                    .padding([.top, .leading])

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(genres, id: \.self) { genre in
                            Button(action: { selectedGenre = genre }) {
                                Text(genre)
                                    .font(.caption)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedGenre == genre ? CinemaTheme.goldHighlight : Color.white.opacity(0.1))
                                    .foregroundColor(selectedGenre == genre ? .black : .white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}