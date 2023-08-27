//
//  Extensions.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


