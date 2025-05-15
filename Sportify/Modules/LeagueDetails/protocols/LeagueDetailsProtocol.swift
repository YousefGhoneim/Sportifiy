//
//  LeagueDetailsProtocol.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

protocol LeagueDetailsViewProtocol: AnyObject {
    func showUpcomingEvents(_ events: [Event])
    func showLatestEvents(_ events: [Event])
    func showTeams(_ teams: [Team])
    func showError(_ message: String)
}

protocol LeagueDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}
