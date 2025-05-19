//
//  Service.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    static let apiKey = "9fa12a9cabfb50c611c248b506b791b187035a8b5d3a288ada3dbce4ba74ecb1"

    static func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"

        AF.request(url).responseData { response in
            guard let data = response.data, !data.isEmpty else {
                completion(.failure(NSError(domain: "No league data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(LeaguesResponse.self, from: data)
                completion(.success(decoded.result ?? []))
            } catch {
                print("Failed to decode Leagues:\n\(String(data: data, encoding: .utf8) ?? "Unreadable")")
                completion(.failure(error))
            }
        }
    }

    static func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        AF.request(url).responseData { response in
            guard let data = response.data, !data.isEmpty else {
                completion(.failure(NSError(domain: "No events data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(EventsResponse.self, from: data)
                let events = decoded.result ?? []
                if events.isEmpty {
                    throw NSError(domain: "No events found", code: 0)
                }
                completion(.success(events))
            } catch {
                print("Failed to decode Events:\n\(String(data: data, encoding: .utf8) ?? "Unreadable")")
                completion(.failure(error))
            }
        }
    }

    static func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        AF.request(url).responseData { response in
            guard let data = response.data, !data.isEmpty else {
                completion(.failure(NSError(domain: "No teams data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(TeamsResponse.self, from: data)
                let teams = decoded.result ?? []
                if teams.isEmpty {
                    throw NSError(domain: "No teams found", code: 0)
                }
                completion(.success(teams))
            } catch {
                print("Failed to decode Teams:\n\(String(data: data, encoding: .utf8) ?? "Unreadable")")
                completion(.failure(error))
            }
        }
    }
    
    static func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void) {
        AF.request(url).responseData { response in
            guard let data = response.data, !data.isEmpty else {
                completion(.failure(NSError(domain: "No player data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(PlayersResponse.self, from: data)
                completion(.success(decoded.result ?? []))
            } catch {
                print("Failed to decode Players:\n\(String(data: data, encoding: .utf8) ?? "Unreadable")")
                completion(.failure(error))
            }
        }
    }

}
