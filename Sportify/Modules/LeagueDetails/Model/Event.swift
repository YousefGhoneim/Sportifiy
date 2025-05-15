//
//  Event.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

struct EventsResponse: Codable {
    let success: Int?
    let result: [Event]?
}

struct Event: Codable {
    let event_key: Int?
    let event_date: String?
    let event_time: String?
    let event_home_team: String?
    let event_away_team: String?
    let event_final_result: String?
    let league_name: String?
    let home_team_logo: String?
    let away_team_logo: String?
}
