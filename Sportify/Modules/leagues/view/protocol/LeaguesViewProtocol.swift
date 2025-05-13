//
//  LeaguesViewProtocol.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    func showLeagues(_ leagues: [League])
    func showError(_ message: String)
}
