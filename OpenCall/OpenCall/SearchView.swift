//
//  SearchView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct SearchView: View {
    @EnvironmentObject var store: AppStore
    @State private var searchText = ""
    @State private var selectedRole = "All"
    
    let roles = ["All", "Actors", "Directors", "Writers", "Cinematographers"]

    // Computed property to handle the filtering logic
    var filteredResults: [SearchResult] {
        searchMockData.filter { person in
            let matchRole = (selectedRole == "All" || person.role.lowercased().contains(selectedRole.lowercased().dropLast())) // dropLast to handle "Actor" vs "Actors"
            let matchSearch = searchText.isEmpty || person.name.localizedCaseInsensitiveContains(searchText)
            return matchRole && matchSearch
        }
    }

    var body: some View {
        NavigationStack { // Enables moving to the Detail View
            ZStack {
                CinemaTheme.deepCharcoal.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Production Archive")
                        .font(.custom("Georgia-Italic", size: 28))
                        .foregroundColor(CinemaTheme.goldHighlight)
                        .padding(.horizontal)

                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search...", text: $searchText).foregroundColor(.white)
                    }
                    .padding(12).background(Color.black.opacity(0.4)).cornerRadius(8).padding(.horizontal)

                    // Filtering Buttons
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(roles, id: \.self) { role in
                                Button(role.uppercased()) { selectedRole = role }
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.horizontal, 12).padding(.vertical, 8)
                                    .background(selectedRole == role ? CinemaTheme.goldHighlight : Color.white.opacity(0.1))
                                    .foregroundColor(selectedRole == role ? .black : .white)
                                    .cornerRadius(4)
                            }
                        }
                        .padding(.horizontal)
                    }

                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(filteredResults) { person in
                                // NAVIGATION LINK: Tapping the card opens the profile
                                NavigationLink(destination: TalentDetailView(person: person)) {
                                    SearchCard(person: person)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct SearchCard: View {
    let person: SearchResult

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {

                // ---------- PHOTO (LOCKED SIZE) ----------
                GeometryReader { geo in
                    if let imageName = person.imageName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    } else {
                        // Fallback (keeps UI identical)
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.white.opacity(0.1))
                                    .font(.system(size: 40))
                            )
                    }
                }
                .aspectRatio(0.8, contentMode: .fit)
                .cornerRadius(4)

                // ---------- ROLE TAG ----------
                Text(person.role)
                    .font(.system(size: 8, weight: .bold))
                    .padding(4)
                    .background(CinemaTheme.accentRed)
                    .foregroundColor(.white)
                    .padding(8)
            }

            Text(person.name)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 4)

            Text(person.specialty)
                .font(.system(size: 10))
                .italic()
                .foregroundColor(CinemaTheme.goldHighlight)
                .padding(.horizontal, 4)
                .padding(.bottom, 8)
        }
        .background(Color.black.opacity(0.3))
        .cornerRadius(4)
    }
}
