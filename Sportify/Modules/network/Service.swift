//
//  Service.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {

    // MARK: - API Key Access
    var apiKey: String {
        return "9fa12a9cabfb50c611c248b506b791b187035a8b5d3a288ada3dbce4ba74ecb1"
    }

    func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        AF.request(url).responseData { response in
            self.decode(response: response, type: LeaguesResponse.self) {
                completion($0.map { $0.result ?? [] })
            }
        }
    }

    func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        AF.request(url).responseData { response in
            self.decode(response: response, type: EventsResponse.self) {
                completion($0.map { $0.result ?? [] })
            }
        }
    }

    func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        AF.request(url).responseData { response in
            self.decode(response: response, type: TeamsResponse.self) {
                completion($0.map { $0.result ?? [] })
            }
        }
    }

    func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void) {
        AF.request(url).responseData { response in
            self.decode(response: response, type: PlayersResponse.self) {
                completion($0.map { $0.result ?? [] })
            }
        }
    }

    // MARK: - Shared Decode Function
    private func decode<T: Decodable>(response: AFDataResponse<Data>, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = response.error {
            completion(.failure(error))
            return
        }
        guard let data = response.data else {
            completion(.failure(NSError(domain: "EmptyData", code: 0)))
            return
        }
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(error))
        }
    }
}
