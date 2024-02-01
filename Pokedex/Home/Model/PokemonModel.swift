//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Joel Villa on 30/01/24.
//

import Foundation

struct Pokemon: Codable {
    let height: Int?
    let id: Int?
    let name: String?
    let sprites: Sprites?
    let weight: Int?
}

struct Sprites: Codable {
    let other: Other?
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
