//
//  NetworkServiceProtocol.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 20/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation


import Foundation

protocol NetworkServiceProtocol {
    var apiKey: String { get }

    func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void)
    func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void)
    func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void)
    func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void)
}
