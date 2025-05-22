//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 17/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UITableViewController, TeamDetailsViewProtocol {

    private var presenter: TeamDetailsPresenterProtocol!
    private var team: Team!
    private var players: [Player] = []
    private var coach: Player?

    // MARK: - Setup Method
    func configure(with team: Team, sport: String) {
        self.team = team
        self.presenter = TeamDetailsPresenter(view: self, team: team, sport: sport)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = team.team_name ?? "Team"
        setupTableView()
        setupHeaderView()
        presenter.viewDidLoad()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        tableView.rowHeight = 100
    }

    private func setupHeaderView() {
        guard let headerView = Bundle.main.loadNibNamed("TeamHeaderView", owner: self, options: nil)?.first as? UIView else {
            return
        }

        if let logo = team.team_logo,
           let url = URL(string: logo),
           let logoImageView = headerView.viewWithTag(1) as? UIImageView {
            logoImageView.kf.setImage(with: url)
        }

        if let nameLabel = headerView.viewWithTag(2) as? UILabel {
            let name = team.team_name?.trimmingCharacters(in: .whitespacesAndNewlines)
            nameLabel.text = (name?.isEmpty == false) ? name : "Team"
            nameLabel.textColor = .label // system color for light/dark mode
            nameLabel.backgroundColor = .clear
        }

        if let coachLabel = headerView.viewWithTag(6) as? UILabel {
            if let coachName = coach?.player_name, !coachName.isEmpty {
                coachLabel.text = "👨‍🏫 Coach: \(coachName)"
            } else {
                coachLabel.text = nil
            }
            coachLabel.textColor = .label
            coachLabel.backgroundColor = .clear
        }

        headerView.subviews.forEach { subview in
            let isUntagged = subview.tag == 0
            let isBlack = subview.backgroundColor == .black
            if isUntagged && isBlack {
                subview.removeFromSuperview()
            }
        }

        headerView.layoutIfNeeded()

        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        headerView.frame.size.height = headerSize.height

        tableView.tableHeaderView = headerView
    }

    // MARK: - TeamDetailsViewProtocol

    func showTeamInfo(_ team: Team) {
        self.team = team
        setupHeaderView()
    }

    func showPlayers(_ players: [Player]) {
        self.coach = players.first(where: { $0.player_type?.lowercased() == "coach" })
        self.players = players.filter { $0.player_type?.lowercased() != "coach" }

        DispatchQueue.main.async {
            self.setupHeaderView()
            self.tableView.reloadData()
        }
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = players[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: player)
        return cell
    }
}
