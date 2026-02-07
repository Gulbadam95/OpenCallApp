//
//  ScreeningView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import SwiftUI

struct ScreeningView: View {
    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            VStack {
                Text("Now Screening")
                    .font(.custom("Georgia-Italic", size: 34))
                    .foregroundColor(CinemaTheme.goldHighlight)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        FilmStripCard {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("DRAMA / THRILLER")
                                        .font(.caption2.bold())
                                        .foregroundColor(CinemaTheme.accentRed)
                                    Spacer()
                                    Image(systemName: "bookmark.fill")
                                        .foregroundColor(CinemaTheme.goldHighlight)
                                }
                                
                                Text("The Last Projection")
                                    .font(.custom("Georgia-Italic", size: 24))
                                    .foregroundColor(.white)
                                
                                Text("by Elena Vasquez")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(.gray)
                                
                                Divider().background(Color.gray)
                                
                                InfoRow(label: "FORMAT", value: "Feature Film")
                                InfoRow(label: "BUDGET", value: "$2M - $5M")
                                InfoRow(label: "TONE", value: "Atmospheric, Tense")
                                
                                HStack {
                                    TagView(text: "Memory")
                                    TagView(text: "Identity")
                                    TagView(text: "Technology")
                                }
                            }
                            .padding(.vertical)
                        }
                        
                        
                        Circle()
                            .fill(CinemaTheme.goldHighlight)
                            .frame(width: 4, height: 4)
                        
                        
                        FilmStripCard {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Circle()
                                        .stroke(CinemaTheme.goldHighlight, lineWidth: 1)
                                        .frame(width: 40, height: 40)
                                        .overlay(Text("ST").foregroundColor(CinemaTheme.goldHighlight))
                                    
                                    VStack(alignment: .leading) {
                                        Text("Sofia Tremaine").foregroundColor(.white).bold()
                                        Text("Vulnerable, Intense").font(.caption).italic().foregroundColor(CinemaTheme.goldHighlight)
                                    }
                                    Spacer()
                                    Image(systemName: "bookmark")
                                        .foregroundColor(.gray)
                                }
                                
                                Text("Classically trained with a focus on psychological drama. Three years of independent film work.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                InfoRow(label: "AGE", value: "24-30")
                                InfoRow(label: "LANGUAGE", value: "English, French")
                            }
                            .padding(.vertical)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
        }
    }
}


struct InfoRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(CinemaTheme.goldHighlight)
            Text("·")
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 12))
                .foregroundColor(.white)
        }
    }
}
