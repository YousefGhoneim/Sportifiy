//
//  LeaguesViewController.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

class LeaguesViewController: UIViewController {
    var selectedSport: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedSport ?? "Leagues"
        view.backgroundColor = .white

        // For now, just print the sport
        if let sport = selectedSport {
            print("Loading leagues for sport: \(sport)")
        }
    }
}
