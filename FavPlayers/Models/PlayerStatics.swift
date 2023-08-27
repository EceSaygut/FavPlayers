//
//  PlayerStatics.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import Foundation

struct PlayerStatistics: Codable {
    let gamesPlayed: Int
    let min: String
    let pts: Double
    let reb: Double
    let ast: Double
    
    private enum CodingKeys: String, CodingKey {
        case gamesPlayed = "games_played"
        case min
        case pts
        case reb
        case ast
    }
}

struct PlayerStatisticsResponse: Codable {
    let data: [PlayerStatistics]
}
