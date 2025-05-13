//
//  LeaguesResponse.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

struct LeaguesResponse: Codable {
    let success: Int?
    let result: [League]?
}

struct League: Codable {
    let league_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}
