//
//  Team.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

struct TeamsResponse: Codable {
    let success: Int?
    let result: [Team]?
}

struct Team: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?

    //  Stadium Info
    let team_stadium: String?
    let team_stadium_capacity: String?
    let team_stadium_location: String?
    let team_stadium_image: String?

    //  Basic Info
    let team_country: String?
    let team_founded: String?
    let team_description_en: String?
}
