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

        AF.request(url).responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let data):
                if let leagues = data.result {
                    completion(.success(leagues))
                } else {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        AF.request(url).responseDecodable(of: EventsResponse.self) { response in
            switch response.result {
            case .success(let data):
                if let events = data.result {
                    completion(.success(events))
                } else {
                    completion(.failure(NSError(domain: "No events", code: 0)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        AF.request(url).responseDecodable(of: TeamsResponse.self) { response in
            switch response.result {
            case .success(let data):
                if let teams = data.result {
                    completion(.success(teams))
                } else {
                    completion(.failure(NSError(domain: "No teams", code: 0)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
