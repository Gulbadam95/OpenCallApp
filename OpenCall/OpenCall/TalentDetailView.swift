//
//  TalentDetailView.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import SwiftUI

struct TalentDetailView: View {
    let person: SearchResult
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            CinemaTheme.deepCharcoal.ignoresSafeArea()
            
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    
                    ZStack {
                        Circle()
                            .stroke(CinemaTheme.goldHighlight, lineWidth: 2)
                            .frame(width: 130, height: 130)
                        
                        Text(person.name.prefix(1))
                            .font(.system(size: 50, design: .serif))
                            .foregroundColor(CinemaTheme.goldHighlight)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 8) {
                        Text(person.name.uppercased())
                            .font(.custom("Georgia", size: 28))
                            .foregroundColor(.white)
                        
                        Text(person.role)
                            .font(.system(size: 12, weight: .bold))
                            .tracking(4)
                            .foregroundColor(CinemaTheme.accentRed)
                    }

                    // Stats Row
                    HStack(spacing: 30) {
                        VStack {
                            Text("12").bold().foregroundColor(.white)
                            Text("PROJECTS").font(.system(size: 8)).foregroundColor(.gray)
                        }
                        VStack {
                            Text("4").bold().foregroundColor(.white)
                            Text("AWARDS").font(.system(size: 8)).foregroundColor(.gray)
                        }
                    }

                    // Detail Sections
                    VStack(alignment: .leading, spacing: 20) {
                        ProfileSection(title: "BIO", content: "A veteran in the field of \(person.specialty), known for a meticulous approach to visual storytelling.")
                        
                        ProfileSection(title: "PREVIOUS EXPERIENCE", content: "• Lead on 'Midnight in Paris' (2024)\n• Visual Consultant for 'Neon Dreams'\n• Sundance Film Festival Finalist")
                    }
                    .padding(.horizontal)
                    
                    
                    Button(action: {
                        store.startConversation(with: person)
                        dismiss() 
                    }) {
                        Text("START DIRECT CHAT")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(CinemaTheme.goldHighlight)
                            .cornerRadius(4)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .padding(.bottom, 100)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct ProfileSection: View {
    let title: String
    let content: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(CinemaTheme.goldHighlight)
            Text(content)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
