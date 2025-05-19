//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

protocol TeamDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    private weak var view: TeamDetailsViewProtocol?
    private let team: Team
    private let sportName: String

    init(view: TeamDetailsViewProtocol, team: Team, sport: String) {
        self.view = view
        self.team = team
        self.sportName = sport
    }

    func viewDidLoad() {
        view?.showTeamInfo(team)
        fetchPlayers()
    }

    private func fetchPlayers() {
        let url = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Players&teamId=\(team.team_key ?? 0)&APIkey=\(NetworkManager.apiKey)"
        
        NetworkManager.fetchPlayers(from: url) { [weak self] result in
            switch result {
            case .success(let players):
                self?.view?.showPlayers(players)
            case .failure(let error):
                self?.view?.showError("Failed to load players: \(error.localizedDescription)")
            }
        }
    }
}
