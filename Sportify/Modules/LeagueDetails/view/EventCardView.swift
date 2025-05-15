//
//  EventCardView.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Kingfisher

class EventCardView: UIView {

    private let homeLogo = UIImageView()
    private let awayLogo = UIImageView()
    private let homeLabel = UILabel()
    private let awayLabel = UILabel()
    private let scoreLabel = UILabel()

    init(event: Event) {
        super.init(frame: .zero)
        setupLayout()
        configure(with: event)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        layer.cornerRadius = 12
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true

        let logosStack = UIStackView(arrangedSubviews: [homeLogo, awayLogo])
        logosStack.axis = .horizontal
        logosStack.spacing = 16
        logosStack.distribution = .equalSpacing

        homeLogo.contentMode = .scaleAspectFit
        awayLogo.contentMode = .scaleAspectFit
        homeLogo.clipsToBounds = true
        awayLogo.clipsToBounds = true
        homeLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        awayLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true

        let labelsStack = UIStackView(arrangedSubviews: [homeLabel, scoreLabel, awayLabel])
        labelsStack.axis = .horizontal
        labelsStack.spacing = 8
        labelsStack.distribution = .equalCentering

        homeLabel.font = .systemFont(ofSize: 14)
        awayLabel.font = .systemFont(ofSize: 14)
        homeLabel.textAlignment = .left
        awayLabel.textAlignment = .right

        scoreLabel.font = .boldSystemFont(ofSize: 16)
        scoreLabel.textAlignment = .center

        let mainStack = UIStackView(arrangedSubviews: [logosStack, labelsStack])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func configure(with event: Event) {
        homeLabel.text = event.event_home_team
        awayLabel.text = event.event_away_team
        scoreLabel.text = event.event_final_result ?? event.event_time

        if let homeLogoURL = event.home_team_logo, let url = URL(string: homeLogoURL) {
            homeLogo.kf.setImage(with: url, placeholder: UIImage(systemName: "house"))
        }
        if let awayLogoURL = event.away_team_logo, let url = URL(string: awayLogoURL) {
            awayLogo.kf.setImage(with: url, placeholder: UIImage(systemName: "flag"))
        }
    }
}
