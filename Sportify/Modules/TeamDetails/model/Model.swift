//
//  Model.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

struct PlayersResponse: Codable {
    let success: Int?
    let result: [Player]?
}

struct Player: Codable {
    let player_key: Int?
    let player_name: String?
    let player_number: String?
    let player_type: String?
    let player_age: String?
    let player_country: String?
    let player_image: String?
    let player_goals: String?
    let player_yellow_cards: String?
    let player_red_cards: String?
}
