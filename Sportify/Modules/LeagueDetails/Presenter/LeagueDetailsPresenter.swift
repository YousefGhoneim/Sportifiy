//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    private weak var view: LeagueDetailsViewProtocol?
    private let sportName: String
    private let leagueId: Int
    
    init(view: LeagueDetailsViewProtocol, sportName: String, leagueId: Int) {
        self.view = view
        self.sportName = sportName
        self.leagueId = leagueId
    }

    func viewDidLoad() {
        fetchUpcomingEvents()
        fetchLatestEvents()
        fetchTeams()
    }

    private func fetchUpcomingEvents() {
        let from = today()
        let to = futureDate(days: 15)
        let url = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Fixtures&leagueId=\(leagueId)&from=\(from)&to=\(to)&APIkey=\(NetworkManager.apiKey)"
        
        NetworkManager.fetchEvents(from: url) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showUpcomingEvents(events)
            case .failure(let error):
                self?.view?.showError("Upcoming Events Error: \(error.localizedDescription)")
            }
        }
    }

    private func fetchLatestEvents() {
        let from = pastDate(days: 15)
        let to = today()
        let url = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Fixtures&leagueId=\(leagueId)&from=\(from)&to=\(to)&APIkey=\(NetworkManager.apiKey)"
        
        NetworkManager.fetchEvents(from: url) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showLatestEvents(events)
            case .failure(let error):
                self?.view?.showError("Latest Events Error: \(error.localizedDescription)")
            }
        }
    }

    private func fetchTeams() {
        let url = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Teams&leagueId=\(leagueId)&APIkey=\(NetworkManager.apiKey)"
        
        NetworkManager.fetchTeams(from: url) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.view?.showTeams(teams)
            case .failure(let error):
                self?.view?.showError("Teams Error: \(error.localizedDescription)")
            }
        }
    }

    // Helper functions
    private func today() -> String {
        return dateString(from: 0)
    }

    private func futureDate(days: Int) -> String {
        return dateString(from: days)
    }

    private func pastDate(days: Int) -> String {
        return dateString(from: -days)
    }

    private func dateString(from offset: Int) -> String {
        let date = Calendar.current.date(byAdding: .day, value: offset, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
