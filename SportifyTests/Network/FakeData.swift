//
//  FakeData.swift
//  SportifyTests
//
//  Created by Yousef Ghoneim on 20/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation
@testable import Sportify

let fakeLeagues: [League] = [
    League(
        league_key: 1,
        league_name: "Test League A",
        country_key: 100,
        country_name: "Mockland",
        league_logo: nil,
        country_logo: nil
    ),
    League(
        league_key: 2,
        league_name: "Test League B",
        country_key: 101,
        country_name: "Fakeland",
        league_logo: nil,
        country_logo: nil
    )
]

let fakeEvents: [Event] = [
    Event(
        event_key: 10,
        event_date: "2025-06-01",
        event_time: "18:00",
        event_home_team: "Mock FC",
        event_away_team: "Fake United",
        event_final_result: "2 - 1",
        league_name: "Test League A",
        home_team_logo: nil,
        away_team_logo: nil
    )
]

let fakeTeams: [Team] = [
    Team(
        team_key: 1,
        team_name: "Mock FC",
        team_logo: nil,
        team_stadium: "Mock Arena",
        team_stadium_capacity: "20000",
        team_stadium_location: "Nowhere",
        team_stadium_image: nil,
        team_country: "Mockland",
        team_founded: "1990",
        team_description_en: "Fake team used for testing."
    )
]

let fakePlayers: [Player] = [
    Player(
        player_key: 101,
        player_name: "John Test",
        player_number: "9",
        player_type: "Forward",
        player_age: "27",
        player_country: "Mockland",
        player_image: nil,
        player_goals: "12",
        player_yellow_cards: "3",
        player_red_cards: "1"
    ),
    Player(
        player_key: 102,
        player_name: "Jane Mock",
        player_number: "1",
        player_type: "Goalkeeper",
        player_age: "25",
        player_country: "Fakeland",
        player_image: nil,
        player_goals: "0",
        player_yellow_cards: "1",
        player_red_cards: "0"
    )
]
