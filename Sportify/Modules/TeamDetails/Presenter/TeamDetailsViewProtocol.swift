//
//  TeamDetailsViewProtocol.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    
    func showTeamInfo(_ team: Team)
    func showPlayers(_ players: [Player])
    func showError(_ message: String)
}
