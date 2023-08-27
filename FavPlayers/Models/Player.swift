//
//  Player.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import Foundation

struct Player: Codable {
    let firstName: String
    let lastName: String
    let position: String
    let team: Team
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case team
    }
}
