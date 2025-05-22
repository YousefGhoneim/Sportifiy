//
//  TeamSectionView.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Kingfisher

protocol TeamSelectionDelegate: AnyObject {
    func didSelectTeam(_ team: Team)
}

class TeamSectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let titleLabel = UILabel()
    private var collectionView: UICollectionView!

    private var teams: [Team] = []
    private var players: [Player] = []
    private var isShowingPlayers = false

    weak var delegate: TeamSelectionDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Teams"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TeamCell.self, forCellWithReuseIdentifier: "TeamCell")
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public Methods

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setTeams(_ teams: [Team]) {
        self.teams = teams
        self.players = []
        self.isShowingPlayers = false

        if teams.isEmpty {
            let label = UILabel()
            label.text = "No Teams Available"
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            label.font = .italicSystemFont(ofSize: 16)
            collectionView.backgroundView = label
        } else {
            collectionView.backgroundView = nil
        }

        collectionView.reloadData()
    }

    func setPlayers(_ players: [Player]) {
        self.players = players
        self.teams = []
        self.isShowingPlayers = true

        if players.isEmpty {
            let label = UILabel()
            label.text = "No Players Available"
            label.textAlignment = .center
            label.textColor = .secondaryLabel
            label.font = .italicSystemFont(ofSize: 16)
            collectionView.backgroundView = label
        } else {
            collectionView.backgroundView = nil
        }

        collectionView.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isShowingPlayers ? players.count : teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell

        if isShowingPlayers {
            let player = players[indexPath.item]
            cell.configure(with: player)
        } else {
            let team = teams[indexPath.item]
            cell.configure(with: team)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isShowingPlayers else {
            // Optional: handle player selection if needed
            return
        }

        let selectedTeam = teams[indexPath.item]
        delegate?.didSelectTeam(selectedTeam)
    }
}
