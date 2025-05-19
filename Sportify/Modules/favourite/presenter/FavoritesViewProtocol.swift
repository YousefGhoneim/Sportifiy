//
//  FavoritesViewProtocol.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import Foundation


protocol FavoritesViewProtocol: AnyObject {
    func showLeagues(_ leagues: [Leagues])
    func showError(_ message: String)
}
