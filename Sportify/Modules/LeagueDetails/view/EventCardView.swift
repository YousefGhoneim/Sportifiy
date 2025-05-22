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
    private let timeLabel = UILabel()
    private let statusLabel = UILabel()

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
        heightAnchor.constraint(equalToConstant: 110).isActive = true

        // Logos
        homeLogo.contentMode = .scaleAspectFit
        awayLogo.contentMode = .scaleAspectFit
        homeLogo.clipsToBounds = true
        awayLogo.clipsToBounds = true
        homeLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        awayLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true

        let logosStack = UIStackView(arrangedSubviews: [homeLogo, awayLogo])
        logosStack.axis = .horizontal
        logosStack.spacing = 16
        logosStack.distribution = .equalSpacing

        // Team Labels
        homeLabel.font = .systemFont(ofSize: 14)
        homeLabel.textAlignment = .left
        awayLabel.font = .systemFont(ofSize: 14)
        awayLabel.textAlignment = .right

        scoreLabel.font = .boldSystemFont(ofSize: 16)
        scoreLabel.textAlignment = .center

        let labelsStack = UIStackView(arrangedSubviews: [homeLabel, scoreLabel, awayLabel])
        labelsStack.axis = .horizontal
        labelsStack.spacing = 8
        labelsStack.distribution = .equalCentering

        // Time Label
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .secondaryLabel
        timeLabel.textAlignment = .center

        // Status Label (invisible, but used for layout)
        statusLabel.font = .systemFont(ofSize: 11, weight: .medium)
        statusLabel.textColor = .clear
        statusLabel.backgroundColor = .clear
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 8
        statusLabel.layer.masksToBounds = true
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true

        // Content priorities to control width distribution
        timeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        statusLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        statusLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        // Bottom stack
        let bottomStack = UIStackView(arrangedSubviews: [timeLabel, statusLabel])
        bottomStack.axis = .horizontal
        bottomStack.spacing = 8
        bottomStack.distribution = .fillProportionally

        // Main stack
        let mainStack = UIStackView(arrangedSubviews: [logosStack, labelsStack, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 6
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
        scoreLabel.text = event.event_final_result?.isEmpty == false ? event.event_final_result : " - "

        if let homeLogoURL = event.home_team_logo, let url = URL(string: homeLogoURL) {
            homeLogo.kf.setImage(with: url, placeholder: UIImage(systemName: "house"))
        }

        if let awayLogoURL = event.away_team_logo, let url = URL(string: awayLogoURL) {
            awayLogo.kf.setImage(with: url, placeholder: UIImage(systemName: "flag"))
        }

        // Format and show time + date
        var datePart = ""
        if let date = event.event_date, !date.isEmpty {
            datePart = "📅 \(date)"
        }

        var timePart = ""
        if let time = event.event_time, !time.isEmpty {
            timePart = "🕒 \(formatTime(time))"
        }

        switch (datePart.isEmpty, timePart.isEmpty) {
        case (false, false):
            timeLabel.text = "\(datePart)   \(timePart)"
        case (false, true):
            timeLabel.text = datePart
        case (true, false):
            timeLabel.text = timePart
        default:
            timeLabel.text = "Date & Time N/A"
        }

        // Keep statusLabel invisible
        statusLabel.text = ""
        statusLabel.backgroundColor = .clear
        statusLabel.textColor = .clear
    }

    private func formatTime(_ militaryTime: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if let date = formatter.date(from: militaryTime) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        } else {
            return militaryTime
        }
    }
}
