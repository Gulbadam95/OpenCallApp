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
    let bio: String
    let tags: [String]
    let initials: String
}

// Mock Data for testing
let mockCreators = [
    Creator(name: "Elena Vasquez", role: "WRITER", bio: "Psychological thrillers and character-driven drama. NYU Tisch grad.", tags: ["Screenwriting", "Noir"], initials: "EV"),
    Creator(name: "Marcus Thorne", role: "ACTOR", bio: "Specializing in period dramas and stage combat. 6'2, baritone.", tags: ["Classical", "Combat"], initials: "MT"),
    Creator(name: "Sasha Kim", role: "DIRECTOR", bio: "Visual storyteller focused on neon-noir aesthetics.", tags: ["Indie", "Short Film"], initials: "SK")
]