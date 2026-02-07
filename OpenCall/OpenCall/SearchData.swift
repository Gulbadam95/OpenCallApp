//
//  SearchData.swift
//  OpenCall
//
//  Created by Gulbadam Rejepova on 2/7/26.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct SearchResult: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let specialty: String
    let imageName: String?     
    var messages: [Message] = []
}

let searchMockData = [
    SearchResult(
        name: "Dominic Thorne",
        role: "ACTOR",
        specialty: "Shakespearian / Modern Noir",
        imageName: "1"
    ),
    SearchResult(
        name: "Clara Von Hess",
        role: "DIRECTOR",
        specialty: "Avant-Garde / Period Drama",
        imageName: "2"
    ),
    SearchResult(
        name: "Leo Ishiguro",
        role: "CINEMATOGRAPHER",
        specialty: "Neon-Noir / Anamorphic",
        imageName: "3"
    ),
    SearchResult(
        name: "Sienna Miller-Reed",
        role: "WRITER",
        specialty: "Psychological Thrillers",
        imageName: "4"
    ),
    SearchResult(
        name: "Marcus Aurelius",
        role: "CREW",
        specialty: "Steadicam Operator",
        imageName: "5"
    ),
    SearchResult(
        name: "Evelyn St. Claire",
        role: "PRODUCER",
        specialty: "Independent Film Finance",
        imageName: "6"
    )
]
