//
//  Creator.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//


import Foundation

struct Creator: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let category: String
    let initials: String
    let imageName: String? // Added this to support your photos
    let bio: String
    let tags: [String]
}

let mockCreators = [
    // --- LEADERSHIP ---
    Creator(name: "Sarah Lane", role: "DP", category: "Crew", initials: "SL", imageName: "1", bio: "Visual storyteller with a focus on natural light.", tags: ["4K", "Arri"]),
    Creator(name: "Maya Chen", role: "Director", category: "Director", initials: "MC", imageName: "2", bio: "Indie filmmaker known for gritty realism.", tags: ["Indie", "Auteur"]),
    Creator(name: "Jameson Burke", role: "1st AD", category: "Crew", initials: "JB", imageName: "3", bio: "The drill sergeant of the set. Keeps us on schedule.", tags: ["Scheduling"]),
    
    // --- CAST ---
    Creator(name: "Marcus Reid", role: "Protagonist", category: "Actor", initials: "MR", imageName: "4", bio: "Method actor with a background in Shakespearean theater.", tags: ["Drama", "Action"]),
    Creator(name: "Elena Rossi", role: "Supporting", category: "Actor", initials: "ER", imageName: "5", bio: "Classical training and a master of accents.", tags: ["Period", "Bilingual"]),
    Creator(name: "Kojo Adé", role: "Antagonist", category: "Actor", initials: "KA", imageName: "6", bio: "High-energy performer specializing in complex villains.", tags: ["Thriller"]),
    
    // --- REPEATING PHOTOS FOR OTHERS ---
    Creator(name: "Sofia Hu", role: "Art Director", category: "Crew", initials: "SH", imageName: "1", bio: "Master of palette and world-building.", tags: ["Set Design"]),
    Creator(name: "Julian Voss", role: "Steadicam Op", category: "Crew", initials: "JV", imageName: "2", bio: "Smooth movement and technical precision.", tags: ["Steady", "Gimbal"]),
    
    // --- PRODUCERS ---
    Creator(name: "Sasha Ivanov", role: "Line Producer", category: "Producer", initials: "SI", imageName: "3", bio: "The master of the spreadsheet and location logistics.", tags: ["Budgeting"]),
    Creator(name: "Jordan Wells", role: "Creative Producer", category: "Producer", initials: "JW", imageName: "4", bio: "Bridging the gap between studio and director.", tags: ["Script Dev"]),
    Creator(name: "Amara Okafor", role: "Post-Producer", category: "Producer", initials: "AO", imageName: "5", bio: "Overseeing everything to the final delivery.", tags: ["Post"]),
    Creator(name: "Hiroshi Tanaka", role: "Co-Producer", category: "Producer", initials: "HT", imageName: "6", bio: "Expert in tax incentives and grants.", tags: ["Grants"])
]
