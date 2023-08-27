//
//  Team.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import Foundation

struct Team: Codable {
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
    }
}


