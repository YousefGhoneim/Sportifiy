//
//  PlayerTableViewCell.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 19/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Kingfisher

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerStatsLabel: UILabel!

    func configure(with player: Player) {
        playerNameLabel.text = player.player_name ?? "Unknown"
        playerPositionLabel.text = player.player_type ?? "N/A"

        let age = player.player_age ?? "-"
        let goals = player.player_goals ?? "0"
        playerStatsLabel.text = "Age: \(age) | Goals: \(goals)"

        if let imageUrl = player.player_image, let url = URL(string: imageUrl) {
            playerImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
        } else {
            playerImageView.image = UIImage(systemName: "person")
        }

        playerImageView.layer.cornerRadius = 20
        playerImageView.clipsToBounds = true
    }
}
