//
//  ProfileView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    ZStack {
                        Circle()
                            .stroke(CinemaTheme.goldHighlight, lineWidth: 2)
                            .frame(width: 160, height: 160)
                        
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 140, height: 140)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        
                       
                        Text("SCREENWRITER")
                            .font(.system(size: 10, weight: .bold))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(CinemaTheme.accentRed)
                            .foregroundColor(.white)
                            .cornerRadius(2)
                            .offset(y: 70)
                    }
                    .padding(.top, 40)
                    
                    VStack(spacing: 5) {
                        Text("Julian Rossi")
                            .font(.custom("Georgia", size: 28))
                            .foregroundColor(.white)
                        Text("London, UK")
                            .font(.caption)
                            .foregroundColor(CinemaTheme.goldHighlight)
                    }

                   
                    FilmStripCard {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("BIOGRAPHY")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(CinemaTheme.goldHighlight)
                            
                            Text("Specializing in Neo-Noir and Period Dramas. Currently developing a series focused on 1940s jazz underground.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineSpacing(4)
                        }
                        .padding(.vertical)
                    }

                    
                    VStack(alignment: .leading) {
                        Text("RECENT CREDITS")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(CinemaTheme.goldHighlight)
                            .padding(.leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(0..<3) { _ in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width: 120, height: 160)
                                        .overlay(
                                            Text("Project\nPoster")
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 120) 
            }
        }
    }
}
