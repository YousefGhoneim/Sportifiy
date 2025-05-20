//
//  EventSectionView.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Kingfisher

class EventSectionView: UIView {

    private let titleLabel = UILabel()
    private let stackView = UIStackView()

    init(title: String) {
        super.init(frame: .zero)
        setupViews()
        titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        // Title Label
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Stack View
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setEvents(_ events: [Event]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if events.isEmpty {
            let label = UILabel()
            label.text = "No Events Available"
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            label.font = .italicSystemFont(ofSize: 16)
            stackView.addArrangedSubview(label)
            return
        }

        for event in events.prefix(10) {
            let card = EventCardView(event: event)
            stackView.addArrangedSubview(card)
        }
    }

}
