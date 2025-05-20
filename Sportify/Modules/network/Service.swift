//
//  Service.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation
import Alamofire


protocol NetworkManagerProtocol {
    
    func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void)
    func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void)
    func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void)
    
    func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void)
    
    
}


class NetworkManager:  NetworkManagerProtocol{

     private let apiKey = "9fa12a9cabfb50c611c248b506b791b187035a8b5d3a288ada3dbce4ba74ecb1"

       func fetchLeagues(forSport sport: String, completion: @escaping (Result<[League], Error>) -> Void) {
           let url = "https://apiv2.allsportsapi.com/\(sport.lowercased())/?met=Leagues&APIkey=\(apiKey)"
           AF.request(url).responseData { response in
            self.handleResponse(data: response.data, error: response.error, type: LeaguesResponse.self) { result in
                   completion(result.map { $0.result ?? [] })
               }
           }
       }

       func fetchEvents(from url: String, completion: @escaping (Result<[Event], Error>) -> Void) {
           AF.request(url).responseData { response in
            self.handleResponse(data: response.data, error: response.error, type: EventsResponse.self) { result in
                   completion(result.map { $0.result ?? [] })
               }
           }
       }

       func fetchTeams(from url: String, completion: @escaping (Result<[Team], Error>) -> Void) {
           AF.request(url).responseData { response in
            self.handleResponse(data: response.data, error: response.error, type: TeamsResponse.self) { result in
                   completion(result.map { $0.result ?? [] })
               }
           }
       }

       func fetchPlayers(from url: String, completion: @escaping (Result<[Player], Error>) -> Void) {
           AF.request(url).responseData { response in
            self.handleResponse(data: response.data, error: response.error, type: PlayersResponse.self) { result in
                   completion(result.map { $0.result ?? [] })
               }
           }
       }

       private func handleResponse<T: Decodable>(data: Data?, error: Error?, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
           if let error = error {
               completion(.failure(error))
               return
           }
           guard let data = data, !data.isEmpty else {
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
