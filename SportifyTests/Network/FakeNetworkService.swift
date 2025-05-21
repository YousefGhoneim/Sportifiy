//
//  FakeNetworkService.swift
//  SportifyTests
//
//  Created by Yousef Ghoneim on 20/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation
@testable import Sportify

class FakeNetworkService: NetworkServiceProtocol {

    var shouldReturnError = false
    var mockLeagues: [League] = []
    var mockEvents: [Event] = []
    var mockTeams: [Team] = []
    var mockPlayers: [Player] = []

    var apiKey: String {
        return "FAKE_API_KEY"
    }

    enum FakeError: Error {
        case forcedFailure
    }

    func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(FakeError.forcedFailure))
        } else {
            completion(.success(mockLeagues))
        }
    }

    func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(FakeError.forcedFailure))
        } else {
            completion(.success(mockEvents))
        }
    }

    func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(FakeError.forcedFailure))
        } else {
            completion(.success(mockTeams))
        }
    }

    func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(FakeError.forcedFailure))
        } else {
            completion(.success(mockPlayers))
        }
    }
}
